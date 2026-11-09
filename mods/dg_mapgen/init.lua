-- Register terrain nodes

core.register_node("dg_mapgen:stone", {
	description = "Stone",
	tiles = { "dg_mapgen_stone.png" },
	groups = { cracky = 3 },
})

core.register_node("dg_mapgen:grass", {
	description = "Grass",
	tiles = { "dg_mapgen_grass.png" },
	groups = { crumbly = 3 },
})

core.register_node("dg_mapgen:dirt", {
	description = "Dirt",
	tiles = { "dg_mapgen_dirt.png" },
	groups = { crumbly = 3 },
})

core.register_node("dg_mapgen:sand", {
	description = "Sand",
	tiles = { "dg_mapgen_sand.png" },
	groups = { crumbly = 3 },
})

-- Register dungeon nodes

core.register_node("dg_mapgen:stone_block", {
	description = "Stone Block",
	tiles = { "dg_mapgen_stone_block.png" },
	is_ground_content = false,
	groups = { dig_immediate = 2 },
})

core.register_node("dg_mapgen:stone_block_stair", {
	description = "Stone Block Stair",
	drawtype = "nodebox",
	tiles = {
		"dg_mapgen_stone_block_divided.png",
		"dg_mapgen_stone_block.png",
		"dg_mapgen_stone_block_divided.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = { dig_immediate = 2 },
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, 0.0, 0.5 },
			{ -0.5, 0.0, 0.0, 0.5, 0.5, 0.5 },
		},
	},
})

-- Register water nodes

core.register_node("dg_mapgen:water_source", {
	description = "Water Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "dg_mapgen_water.png",
			backface_culling = false,
		},
		{
			name = "dg_mapgen_water.png",
			backface_culling = true,
		},
	},
	alpha = 160,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "dg_mapgen:water_flowing",
	liquid_alternative_source = "dg_mapgen:water_source",
	liquid_viscosity = 1,
	post_effect_color = { a = 103, r = 30, g = 60, b = 90 },
})

core.register_node("dg_mapgen:water_flowing", {
	description = "Flowing Water",
	drawtype = "flowingliquid",
	tiles = { "dg_mapgen_water.png" },
	special_tiles = {
		{
			name = "dg_mapgen_water.png",
			backface_culling = false,
		},
		{
			name = "dg_mapgen_water.png",
			backface_culling = false,
		},
	},
	alpha = 160,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "dg_mapgen:water_flowing",
	liquid_alternative_source = "dg_mapgen:water_source",
	liquid_viscosity = 1,
	post_effect_color = { a = 103, r = 30, g = 60, b = 90 },
	groups = { not_in_creative_inventory = 1 },
})

-- Register magma nodes

core.register_node("dg_mapgen:magma_source", {
	description = "Magma Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "dg_mapgen_magma.png",
			backface_culling = false,
		},
		{
			name = "dg_mapgen_magma.png",
			backface_culling = true,
		},
	},
	paramtype = "light",
	light_source = 13,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "dg_mapgen:magma_flowing",
	liquid_alternative_source = "dg_mapgen:magma_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = { a = 191, r = 255, g = 64, b = 0 },
})

core.register_node("dg_mapgen:magma_flowing", {
	description = "Flowing Magma",
	drawtype = "flowingliquid",
	tiles = { "dg_mapgen_magma.png" },
	special_tiles = {
		{
			name = "dg_mapgen_magma.png",
			backface_culling = false,
		},
		{
			name = "dg_mapgen_magma.png",
			backface_culling = false,
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = 13,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "dg_mapgen:magma_flowing",
	liquid_alternative_source = "dg_mapgen:magma_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = { a = 191, r = 255, g = 64, b = 0 },
	groups = { not_in_creative_inventory = 1 },
})

-- Register aliases for map generators

core.register_alias("mapgen_stone", "dg_mapgen:stone")
core.register_alias("mapgen_water_source", "dg_mapgen:water_source")
core.register_alias("mapgen_river_water_source", "dg_mapgen:water_source")

-- Register biomes

-- Grassland biome stack

-- Dry land from beach top to world top

core.register_biome({
	name = "grassland",
	node_top = "dg_mapgen:grass",
	depth_top = 1,
	node_filler = "dg_mapgen:dirt",
	depth_filler = 2,
	node_riverbed = "dg_mapgen:sand",
	depth_riverbed = 2,
	node_cave_liquid = "dg_mapgen:water_source",
	node_dungeon = "dg_mapgen:stone_block",
	node_dungeon_stair = "dg_mapgen:stone_block_stair",
	y_max = 31000,
	y_min = 4,
	heat_point = 50,
	humidity_point = 50,
})

-- The sand of beaches and seabeds

core.register_biome({
	name = "grassland_sea",
	node_top = "dg_mapgen:sand",
	depth_top = 1,
	node_filler = "dg_mapgen:sand",
	depth_filler = 2,
	node_riverbed = "dg_mapgen:sand",
	depth_riverbed = 2,
	node_cave_liquid = "dg_mapgen:water_source",
	node_dungeon = "dg_mapgen:stone_block",
	node_dungeon_stair = "dg_mapgen:stone_block_stair",
	vertical_blend = 1,
	y_max = 3,
	y_min = -127,
	heat_point = 50,
	humidity_point = 50,
})

-- Shallow underground

core.register_biome({
	name = "grassland_under",
	node_cave_liquid = "dg_mapgen:water_source",
	node_dungeon = "dg_mapgen:stone_block",
	node_dungeon_stair = "dg_mapgen:stone_block_stair",
	y_max = -128,
	y_min = -1023,
	heat_point = 50,
	humidity_point = 50,
})

-- Deep underground where magma first appears

core.register_biome({
	name = "grassland_deep",
	node_cave_liquid = { "dg_mapgen:water_source", "dg_mapgen:magma_source" },
	node_dungeon = "dg_mapgen:stone_block",
	node_dungeon_stair = "dg_mapgen:stone_block_stair",
	y_max = -1024,
	y_min = -31000,
	heat_point = 50,
	humidity_point = 50,
})

for nodename, _ in pairs(core.registered_nodes) do
	if nodename:split(":")[1] == "dg_mapgen" then
		core.register_alias("mapgen:" .. nodename:split(":")[2], nodename)
	end
end
