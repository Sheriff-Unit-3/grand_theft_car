-- Nodes

core.register_node("dg_trees:pine_trunk", {
	description = "Pine Trunk",
	tiles = {
		"dg_trees_pine_trunk_top.png",
		"dg_trees_pine_trunk_top.png",
		"dg_trees_pine_trunk_side.png",
	},
	groups = { choppy = 2 },
})

core.register_node("dg_trees:pine_needles", {
	description = "Pine Needles",
	tiles = { "dg_trees_pine_needles.png" },
	walkable = false,
	groups = { dig_immediate = 2 },
})

core.register_alias("trees:pine_trunk", "dg_trees:pine_trunk")
core.register_alias("trees:pine_needles", "dg_trees:pine_needles")

-- Decoration.
-- Placed by voxelmanip in 'track' mod, not by core mapgen, so use:
-- mg_flags = caves,dungeons,light,nodecorations,biomes

--[[
core.register_decoration({
	deco_type = "schematic",
	place_on = { "dg_mapgen:grass" },
	sidelen = 16,
	noise_params = {
		offset = 0.0,
		scale = 0.04,
		spread = { x = 256, y = 256, z = 256 },
		seed = 2,
		octaves = 3,
		persist = 0.7,
	},
	biomes = { "grassland" },
	y_min = -31000,
	y_max = 31000,
	schematic = core.get_modpath("dg_trees") .. "/schematics/dg_trees_pine_tree.mts",
	flags = "place_center_x, place_center_z",
})
]]
