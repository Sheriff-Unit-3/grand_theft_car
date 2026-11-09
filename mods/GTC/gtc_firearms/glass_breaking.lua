core.register_craftitem("gtc_firearms:glass_shards", {
	description = ""
		.. core.colorize("#35cdff", "Glass shards\n")
		.. core.colorize("#FFFFFF", "3 of those, can be crafted into a file of glass fragments"),
	inventory_image = "rangedweapons_glass_shards.png",
})
core.register_craft({
	output = "vessels:glass_fragments",
	recipe = {
		{ "gtc_firearms:glass_shards", "gtc_firearms:glass_shards", "gtc_firearms:glass_shards" },
	},
})

core.register_node("gtc_firearms:broken_glass", {
	description = "Broken glass",
	drawtype = "glasslike",
	tiles = {
		"rangedweapons_broken_glass.png",
	},
	paramtype = "light",
	walkable = false,
	is_ground_content = false,
	liquidtype = "source",
	liquid_alternative_flowing = "gtc_firearms:broken_glass",
	liquid_alternative_source = "gtc_firearms:broken_glass",
	liquid_viscosity = 7,
	alpha = 160,
	liquid_range = 0,
	liquid_renewable = false,
	damage_per_second = 2,
	groups = { oddly_breakable_by_hand = 3 },
})
