local gui = flow.widgets
local game = gtc
local S = core.get_translator("gtc")
local FS = function(...)
	return core.formspec_escape(S(...))
end

local credits = flow.make_gui(function()
	return gui.VBox({
		bgcolor = "#80808060",
		gui.Label({
			label = FS("Credits"),
			align_h = "center",
			style = {
				textcolor = "orange",
				font_size = 24,
			},
		}),
		gui.Textarea({
			default = "Developer/Maintainer:\tSheriff_U3\n"
				.. "Weapons:\tRanged Weapons Contributors\n"
				.. "Wasted death screen:\tTPH\n"
				.. "Flow library:\tluk3yx\n"
				.. "Driftgame base:\tparamat & wsor4035\n"
				.. "Player API:\tMinetest Game Contributors",
			editable = false,
			style = {
				textcolor = "gold",
				font_size = 12,
			},
		}),
		gui.HBox({
			gui.ButtonExit({
				name = "exit",
				label = FS("Exit"),
				expand = true,
				style = {
					{
						sel = "$default",
						bgcolor = "#80808020",
						font_size = 16,
						textcolor = "red",
					},
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
					{
						sel = "$default",
						bgcolor = "#80808020",
						font_size = 16,
						textcolor = "red",
					},
					{
						sel = "$hovered, $pressed",
						bgcolor = "#FF0000",
					},
				},
				min_w = 2.5,
				padding = 0.1,
			}),
		}),
	})
end)

local stats = flow.make_gui(function(player)
	local name = player:get_player_name()
	local statistics = game.players[name]
	return gui.VBox({
		gui.Label({
			name = "statistics",
			label = FS("Statistics"),
			align_h = "center",
			style = {
				textcolor = "orange",
				font_size = 20,
			},
		}),
		gui.Textarea({
			default = FS(
				"Score: @1\nKills: @2\nDeaths: @3",
				tostring(statistics.score),
				tostring(statistics.kills),
				tostring(statistics.deaths)
			),
			editable = false,
			style = {
				textcolor = "gold",
				font_size = 16,
			},
		}),
		gui.HBox({
			gui.ButtonExit({
				name = "exit",
				label = FS("Exit"),
				expand = true,
				style = {
					{
						sel = "$default",
						bgcolor = "#80808020",
						font_size = 16,
						textcolor = "red",
					},
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
					{
						sel = "$default",
						bgcolor = "#80808020",
						font_size = 16,
						textcolor = "red",
					},
					{
						sel = "$hovered, $pressed",
						bgcolor = "#FF0000",
					},
				},
				min_w = 2.5,
				padding = 0.1,
			}),
		}),
	})
end)

local inventory = flow.make_gui(function(player)
	return gui.VBox({
		min_w = 6,
		bgcolor = "#80808060",
		gui.Label({
			label = FS("Grand Theft Car"),
			align_h = "center",
			expand = true,
			style = {
				textcolor = "orange",
				font_size = 24,
			},
		}),
		gui.HBox({
			gui.ButtonExit({
				name = "credits",
				label = FS("Credits"),
				expand = true,
				on_event = function(player2)
					credits:show(player2)
				end,
				style = {
					{
						sel = "$default",
						bgcolor = "#80808020",
						font_size = 16,
					},
				},
				min_w = 2.5,
				padding = 0.1,
			}),
			gui.ButtonExit({
				name = "statistics",
				label = FS("Stats"),
				expand = true,
				on_event = function(player2)
					stats:show(player2)
				end,
				style = {
					{
						sel = "$default",
						bgcolor = "#80808020",
						font_size = 16,
					},
				},
				min_w = 2.5,
				padding = 0.1,
			}),
		}),
		gui.HBox({
			gui.ButtonExit({
				name = "exit",
				label = FS("Exit"),
				expand = true,
				style = {
					{
						sel = "$default",
						bgcolor = "#80808020",
						font_size = 16,
						textcolor = "red",
					},
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
					{
						sel = "$default",
						bgcolor = "#80808020",
						font_size = 16,
						textcolor = "red",
					},
					{
						sel = "$hovered, $pressed",
						bgcolor = "#FF0000",
					},
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
