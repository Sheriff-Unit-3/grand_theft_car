--[[
(C) TPH/tph9677/TubberPupperHusker/TubberPupper/Damotrix
(C) 2026 Sheriff_U3
MIT License
https://opensource.org/license/mit

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]
-- yeah because you're getting absolutely WASTED

local game = gtc
local wtd = {
	frametime = 0.05, -- seconds between each frame
	-- let outside mods modify this
	sounds = {
		-- plays when player initially dies
		click = {
			name = "wasted_click",
		},
		-- spooky sound meant to play in the background
		spook = {
			name = "wasted_spook",
			gain = 0.1,
		},
		-- plays when WASTED text appears
		belltoll = {
			name = "wasted_belltoll",
			pitch = 0.875,
			gain = 0.3,
		},
	},
	-- length of each phase and intermediatory period
	firstlength = 1.6, -- click sound, initial desaturation
	waitlength = 2.5, -- how long between the first and second phases (click and belltoll)
	secondlength = 0.8, -- belltoll, 2nd desaturation with the death HUD
	waitlength2 = 1, -- how long between second and third phase (belltoll vs red text desaturation)
	thirdlength = 1, -- turning red text to white
}

gtc.wasted = wtd

-- calculate From-Goal values
local function CFGV(pdata)
	local goal, from = pdata.goal, pdata.from
	if not (goal and from) then
		return
	end
	-- iterate over each value we share
	for name, value in pairs(from) do
		if goal[name] then
			-- clamp above 0
			pdata[name .. "diff"] = math.max(value - goal[name], 0)
		end
	end
end

-- gets ran by the below step if player is dead
local function act(pdata)
	local phase = pdata.phase or 1 -- decree phase
	local plr = pdata.obj
	-- do the phases!
	-- initial desaturating
	if phase == 1 then
		-- we've not started yet
		if not pdata.goal then
			-- hide it so player can't respawn until the banner has appeared
			core.show_formspec(pdata.name, "__builtin:death", "")
			-- get 'n set player physics to prevent movement
			pdata.physics = plr:get_physics_override()
			local plrphys = table.copy(pdata.physics)
			plrphys.speed_walk = 0
			plr:set_physics_override(plrphys)
			-- get and hide HUD flags
			pdata.hud_flags = plr:hud_get_flags()
			-- now to hide
			plr:hud_set_flags({
				crosshair = false,
				wielditem = false,
				hotbar = false,
			})
			-- set phase
			pdata.phase = 1
			-- create sounds table
			pdata.sounds_playing = {}
			-- play sounds
			local sounds = { table.copy(wtd.sounds.spook), table.copy(wtd.sounds.click) }
			for _, sound in ipairs(sounds) do
				sound.to_player = pdata.name
				-- add ID to table
				table.insert(pdata.sounds_playing, core.sound_play(sound.name, sound))
			end
			-- visuals
			-- create sepia vision hud
			if not pdata.VISIONBLUR then
				pdata.VISIONBLUR = plr:hud_add({
					type = "image",
					text = "wasted_vision_blur_sepia.png^[opacity:200",
					position = { x = 0.5, y = 0.5 },
					scale = { x = -100, y = -100 },
				})
			end
			-- get lighting
			pdata.lighting = plr:get_lighting()
			-- set for original
			pdata.origlighting = table.copy(pdata.lighting)
			-- create goal
			pdata.goal = {
				length = wtd.firstlength, -- how long the phase lasts
				saturation = 0.26,
				bloomsity = 0, -- bloom intensity
				visionbluropacity = 20, -- sepia border around screen
			}
			-- create from (for calculating how far we've come)
			pdata.from = {
				saturation = pdata.lighting.saturation,
				bloomsity = pdata.lighting.bloom.intensity + 0.55,
				visionbluropacity = 200,
			}
			-- calculate our differences
			CFGV(pdata)
		end
		-- actually do stuff
		local l = pdata.lighting
		-- elapsed percentage, clamp below 1
		local eperc = math.min(pdata.timer / pdata.goal.length, 1)
		-- do changes
		if pdata.saturationdiff ~= 0 then
			l.saturation = pdata.from.saturation - (pdata.saturationdiff * eperc)
		end
		if pdata.bloomsitydiff ~= 0 then
			l.bloom.intensity = pdata.from.bloomsity - (pdata.bloomsitydiff * eperc)
		end
		-- fading mechanics
		-- have to grab texture modifier text and change it up
		if pdata.VISIONBLUR and pdata.visionbluropacitydiff and pdata.visionbluropacitydiff ~= 0 then
			local matchbit = "%^%[opacity:%d+"
			local text = plr:hud_get(pdata.VISIONBLUR).text
			-- calculate new opacity
			local newopac = math.floor(pdata.from.visionbluropacity - (pdata.visionbluropacitydiff * eperc))
			-- DESTROY
			if newopac == 0 then
				plr:hud_remove(pdata.VISIONBLUR)
				pdata.VISIONBLUR = nil
				-- updating opacity
			else
				text = text:gsub(matchbit, "^[opacity:" .. newopac)
				plr:hud_change(pdata.VISIONBLUR, "text", text)
			end
		end
		-- end phase
		if eperc == 1 then
			-- tell us to refresh stuff for other phases
			pdata.refreshneeded = true
			-- next phase, reset timer
			pdata.phase = phase + 1
			pdata.timer = 0
			-- delete and set lighting
			plr:set_lighting(pdata.lighting)
			pdata.lighting = nil
		end
		-- intermission
	elseif phase == 2 then
		-- wait for exactly the proceeded length in seconds!
		if pdata.timer >= wtd.waitlength then
			pdata.phase = phase + 1
			pdata.timer = 0
		end
		-- next phase, WASTED sign
	elseif phase == 3 then
		if pdata.refreshneeded then
			-- add sign
			if not pdata.WASTED then
				pdata.WASTED = plr:hud_add({
					type = "image",
					text = "wasted.png^[opacity:200^(wasted_red.png^[opacity:255)",
					position = { x = 0.5, y = 0.5 },
					scale = { x = -100, y = -50 },
				})
			end
			-- add regular blurred vision
			if not pdata.VISIONBLUR then
				pdata.VISIONBLUR = plr:hud_add({
					type = "image",
					text = "wasted_vision_blur.png^[opacity:255",
					position = { x = 0.5, y = 0.5 },
					scale = { x = -100, y = -100 },
				})
				-- ENSURE THAT IMAGE IS CHANGED
			elseif pdata.VISIONBLUR then
				plr:hud_change(pdata.VISIONBLUR, "text", "wasted_vision_blur.png^[opacity:255")
			end
			-- play sound
			local toll = table.copy(wtd.sounds.belltoll)
			toll.to_player = pdata.name
			table.insert(pdata.sounds_playing, core.sound_play(toll.name, toll))
			-- get data again
			pdata.lighting = plr:get_lighting()
			-- ideally should derive from previous goal but just in case
			pdata.from = {
				-- add 0.3 to saturation
				saturation = (pdata.goal and pdata.goal.saturation or pdata.lighting.saturation) + 0.3,
				-- add 0.72 to bloom intensity
				bloomsity = (pdata.goal and pdata.goal.bloomsity or pdata.lighting.bloom.intensity) + 0.72,
				-- encroaching vision shadow
				visionbluropacity = 255,
			}
			pdata.goal = {
				length = wtd.secondlength,
				saturation = 0,
				bloomsity = 0.3,
				visionbluropacity = 100, -- encroaching vision shadow
			}
			-- calculate our differences
			CFGV(pdata)
			-- refresh no longer needed
			pdata.refreshneeded = nil
		end
		-- actually do stuff
		local l = pdata.lighting
		-- elapsed percentage, clamp below 1
		local eperc = math.min(pdata.timer / pdata.goal.length, 1)
		-- do changes
		if pdata.saturationdiff ~= 0 then
			l.saturation = pdata.from.saturation - (pdata.saturationdiff * eperc)
		end
		if pdata.bloomsitydiff ~= 0 then
			l.bloom.intensity = pdata.from.bloomsity - (pdata.bloomsitydiff * eperc)
		end
		-- fading mechanics
		-- have to grab texture modifier text and change it up
		if pdata.VISIONBLUR and pdata.visionbluropacitydiff and pdata.visionbluropacitydiff ~= 0 then
			local matchbit = "%^%[opacity:%d+"
			local text = plr:hud_get(pdata.VISIONBLUR).text
			-- calculate new opacity
			local newopac = math.floor(pdata.from.visionbluropacity - (pdata.visionbluropacitydiff * eperc))
			-- DESTROY (if we're told to do this)
			if newopac == 0 then
				plr:hud_remove(pdata.VISIONBLUR)
				pdata.VISIONBLUR = nil
				-- updating opacity
			else
				text = text:gsub(matchbit, "^[opacity:" .. newopac)
				plr:hud_change(pdata.VISIONBLUR, "text", text)
			end
		end
		-- end phase
		if eperc == 1 then
			pdata.phase = phase + 1
			pdata.timer = 0
			-- set and delete lighting
			plr:set_lighting(pdata.lighting)
			pdata.lighting = nil
			-- delete goal and from tables
			pdata.from, pdata.goal = nil, nil
		end
		-- intermission between text staying red and fading out
	elseif phase == 4 then
		-- wait for exactly the proceeded length in seconds!
		if pdata.timer >= wtd.waitlength2 then
			pdata.phase = phase + 1
			pdata.timer = 0
		end
		-- text fading to white
	elseif phase == 5 then
		-- create text fading goal
		if not pdata.goal then
			-- turn red text to white
			pdata.from = {
				redopacity = 255,
			}
			-- by reducing it 'til 0 and deleting!
			pdata.goal = {
				length = wtd.thirdlength,
				redopacity = 0,
			}
			-- calculate our differences
			CFGV(pdata)
			-- refresh no longer needed
			pdata.refreshneeded = nil
		end
		-- elapsed percentage, clamp below 1
		local eperc = math.min(pdata.timer / pdata.goal.length, 1)
		-- fading mechanics
		-- have to grab texture modifier text and change it up
		if pdata.redopacitydiff and pdata.redopacitydiff ~= 0 then
			local matchbit = "%^%(wasted_red%.png%^%[opacity:%d+%)"
			local text = plr:hud_get(pdata.WASTED).text
			-- calculate new opacity
			local newopac = math.floor(pdata.from.redopacity - (pdata.redopacitydiff * eperc))
			if newopac == 0 then
				text = text:gsub(matchbit, "")
				pdata.redopacitydiff = nil -- just to prevent this from running again
				-- updating the opacity
			else
				text = text:gsub(matchbit, "^(wasted_red.png^[opacity:" .. newopac .. ")")
			end
			-- UPDATE TEXT
			plr:hud_change(pdata.WASTED, "text", text)
		end
		-- FINALLY end phase
		if eperc == 1 then
			pdata.phase = phase + 1
			pdata.timer = 0
			-- replace death formspec with a transparent and button-less one
			-- just so that players can STILL respawn if they need to
			core.show_formspec(
				pdata.name,
				"__builtin:death",
				table.concat({
					"formspec_version[3]",
					"size[0.01,0.01,true]",
					"position[-1,-1]",
					"bgcolor[;<neither>;]",
				})
			)
			-- restore player movement
			plr:set_physics_override(pdata.physics)
		end
	end
	-- update lighting
	if pdata.lighting then
		plr:set_lighting(pdata.lighting)
	end
end

-- gets ran when a formerly running functionality is interrupted or finished
local function actoff(pdata)
	-- player stuff
	local plr = pdata.obj
	-- unhide huds (revert to previous setting)
	plr:hud_set_flags(pdata.hud_flags)
	-- refresh lighting effects
	local lighting = pdata.origlighting or nil
	plr:set_lighting(lighting)
	-- delete wasted hud
	if pdata.WASTED then
		plr:hud_remove(pdata.WASTED)
	end
	-- delete vision blur hud
	if pdata.VISIONBLUR then
		plr:hud_remove(pdata.VISIONBLUR)
	end
	-- stop all sounds
	if not pdata.sounds_playing then
		return
	end -- oops!
	for _, sID in ipairs(pdata.sounds_playing) do -- sound ID
		core.sound_stop(sID)
	end
end

-- player data
local pdatas = {}

-- return a pdata equaling to provided player or player's name
local function retrieve_pdata(plr)
	for ind, pdata in ipairs(pdatas) do
		-- player object, or player name
		if pdata.obj == plr or pdata.name == plr then
			return pdata, ind -- return index as a 2nd argument
		end
	end
end

-- functions for starting and ending the WASTED functionality
-- expects player object
local function initiate(plr)
	-- already dead! no duplication
	if retrieve_pdata(plr) then
		return
	end
	-- create data
	local pdata = {
		name = plr:get_player_name(),
		obj = plr,
		timer = 0,
	}
	-- add to list
	table.insert(pdatas, pdata)
	-- BEGIN ACT
	act(pdata)
	-- return player data
	return pdata
end

-- remove player from WASTED functionality
local function remove(plr)
	local pdata, ind = retrieve_pdata(plr)
	if not pdata then
		return false, false
	end -- nothing to end
	table.remove(pdatas, ind)
	-- END ACT
	-- player has left or otherwise no longer exists
	-- return true, false - true for successful removal, false for lacking player
	if not pdata.obj:get_properties() then
		return true, false
	end
	actoff(pdata)
	-- successful removal AND proper player
	return true, true
end

-- stuff to be ran on events
-- run WASTED mechanic if player is dead
core.register_on_joinplayer(function(plr)
	if plr:get_hp() > 0 then
		return
	end -- not dead
	-- is dead!
	initiate(plr)
end)

-- remove player data upon leave
core.register_on_leaveplayer(function(plr)
	remove(plr)
end)

-- reset alive
core.register_on_respawnplayer(function(plr)
	-- end
	remove(plr)
end)

-- no longer alive!!!
core.register_on_dieplayer(function(plr, reason)
	initiate(plr)
end)

-- run loop for more accurate timing than `after` threads
local ctime = 0 -- check time
core.register_globalstep(function(dtime)
	ctime = ctime + dtime
	-- you want a delay ok sure
	if wtd.frametime ~= 0 then
		if ctime < wtd.frametime then
			return
		end -- don't iterate through player datas
	end
	-- no one is dead
	if #pdatas == 0 then
		ctime = 0 -- clear the time
		return
	end
	for _, pdata in ipairs(pdatas) do
		-- set
		pdata.timer = pdata.timer + ctime
		-- run functionality
		act(pdata)
	end
	-- set ctime to 0 after iteration
	ctime = 0
end)

-- accessible API functions

-- get player data table, returns nil if does not exist or invalid
-- permits player object or player name
function wtd.get_player_data(plr)
	return retrieve_pdata(plr)
end

-- if player is currently experiencing the wasted screen (has player data), returns true, false otherwise
function wtd.is_player_wasted(plr)
	return retrieve_pdata(plr) ~= nil
end

-- permits initiating the screen
function wtd.waste_player(plr)
	-- returns player data on success, nil otherwise
	return initiate(plr)
end

-- removes screen
-- returns 2 booleans - first for successful removal, second for whether or not player properly exists
function wtd.remove_wasted(plr)
	return remove(plr)
end
