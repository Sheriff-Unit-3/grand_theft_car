local game = {
	players = {},
}
local storage = core.get_mod_storage()

core.register_on_joinplayer(function(player, last_login)
	local name = player:get_player_name()
	game.players[name] = {}
	if storage:contains(name) then
		game.players[name] = core.parse_json(storage:get_string(name))
	else
		game.players[name] = {
			score = 0,
			kills = 0,
			deaths = 0,
			wanted_level = 0,
		}
	end
end)

core.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	storage:set_string(name, core.write_json(game.players[name]))
end)

core.register_on_dieplayer(function(player, reason)
	local name = player:get_player_name()
	game.players[name].deaths = game.players[name].deaths + 1
	core.log("action", "[Event]: " .. name .. " died")
	core.log("error", "deaths = " .. tostring(game.players[name].deaths))
end)

core.register_on_newplayer(function(player)
	local currpos = player:get_pos()
	player:set_pos(vector.new(currpos.x, currpos.y + 20, currpos.z))
end)

gtc = game
