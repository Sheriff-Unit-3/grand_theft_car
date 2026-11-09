local gui = flow.widgets
local game = gtc
local S = core.get_translator("gtc")
local FS = function(...)
	return core.formspec_escape(S(...))
end

local credits = gui.VBox({
	gui.Label({ label = FS("Credits"), align_h = "center" }),
})

local inventory = flow.make_gui(function(player)
	local name = player:get_player_name()
	local stats = game.players[name]
	return gui.VBox({
		min_w = 6,
		bgcolor = "#80808060",
		gui.Label({
			label = FS("Grand Theft Car"),
			align_h = "center",
			expand = true,
			style = { font_size = 24 },
		}),
		gui.Label({
			name = "statistics",
			label = FS("Statistics"),
			align_h = "center",
			style = {
				font_size = 20,
			},
		}),
		gui.Textarea({
			default = FS(
				"Score: @1\nKills: @2\nDeaths: @3",
				tostring(stats.score),
				tostring(stats.kills),
				tostring(stats.deaths)
			),
			editable = false,
			style = {
				font_size = 16,
			},
		}),
		gui.HBox({
			gui.ButtonExit({
				name = "exit",
				label = FS("Exit"),
				expand = true,
				style = {
					{ sel = "$default", bgcolor = "#80808020", font_size = 16 },
				},
				padding = 0.1,
			}),
			gui.ButtonExit({
				name = "exit_game",
				label = FS("Exit Game"),
				expand = true,
				on_event = function(player2)
					core.kick_player(player2:get_player_name(), FS("You clicked 'Exit Game'"), true)
				end,
				style = {
					{ sel = "$default", bgcolor = "#80808020", font_size = 16 },
					{ sel = "$hovered, $pressed", bgcolor = "#FF0000" },
				},
				min_w = 2.5,
				padding = 0.1,
			}),
		}),
	})
end)

core.register_on_joinplayer(function(player)
	inventory:set_as_inventory_for(player)
end)
