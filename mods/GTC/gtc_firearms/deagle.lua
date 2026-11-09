core.register_tool("gtc_firearms:deagle_rld", {
	stack_max = 1,
	wield_scale = { x = 1.25, y = 1.25, z = 1.5 },
	description = "",
	range = 0,
	loaded_gun = "gtc_firearms:deagle",
	groups = { not_in_creative_inventory = 1 },
	inventory_image = "rangedweapons_deagle_rld.png",
})
core.register_tool("gtc_firearms:deagle_r", {
	stack_max = 1,
	wield_scale = { x = 1.25, y = 1.25, z = 1.5 },
	description = "",
	range = 0,
	rw_next_reload = "gtc_firearms:deagle",
	load_sound = "rangedweapons_handgun_mag_in",
	groups = { not_in_creative_inventory = 1 },
	inventory_image = "rangedweapons_deagle_rld.png",
})

core.register_tool("gtc_firearms:deagle", {
	description = ""
		.. core.colorize("#35cdff", "Desert Eagle\n")
		.. core.colorize("#FFFFFF", "Ranged damage: 11\n")
		.. core.colorize("#FFFFFF", "Accuracy: 85%\n")
		.. core.colorize("#FFFFFF", "knockback: 6\n")
		.. core.colorize("#FFFFFF", "Critical chance: 20%\n")
		.. core.colorize("#FFFFFF", "Critical efficiency: 3x\n")
		.. core.colorize("#FFFFFF", "Reload delay: 0.6\n")
		.. core.colorize("#FFFFFF", "Clip size: 9/8/7\n")
		.. core.colorize("#FFFFFF", "Ammunition: .357 Magnum rounds/.44 magnum rounds/.50AE catridges\n")
		.. core.colorize("#FFFFFF", "Rate of fire: 0.7\n")
		.. core.colorize("#FFFFFF", "Gun type: Magnum\n")
		.. core.colorize("#FFFFFF", "Block penetration: 5%\n")
		.. core.colorize("#FFFFFF", "penetration: 15%\n")
		.. core.colorize("#FFFFFF", "Bullet velocity: 50"),
	wield_scale = { x = 1.25, y = 1.25, z = 1.5 },
	range = 0,
	inventory_image = "rangedweapons_deagle.png",
	RW_gun_capabilities = {
		gun_damage = { fleshy = 11, knockback = 6 },
		gun_crit = 20,
		gun_critEffc = 2.2,
		suitable_ammo = { { "gtc_firearms:357", 9 }, { "gtc_firearms:44", 8 }, { "gtc_firearms:50ae", 7 } },
		gun_skill = { "revolver_skill", 40 },
		gun_magazine = "gtc_firearms:handgun_mag_white",
		gun_unloaded = "gtc_firearms:deagle_r",
		gun_cooling = "gtc_firearms:deagle_rld",
		gun_velocity = 50,
		gun_accuracy = 85,
		gun_cooldown = 0.7,
		gun_reload = 0.6 / 1,
		gun_projectiles = 1,
		has_shell = 1,
		gun_durability = 900,
		gun_smokeSize = 7,
		gun_mob_penetration = 15,
		gun_node_penetration = 5,
		gun_unload_sound = "rangedweapons_handgun_mag_out",
		gun_sound = "rangedweapons_deagle",
	},
	on_secondary_use = function(itemstack, user, pointed_thing)
		rangedweapons_reload_gun(itemstack, user)
		return itemstack
	end,
	on_use = function(itemstack, user, pointed_thing)
		rangedweapons_shoot_gun(itemstack, user)
		return itemstack
	end,
})

core.register_tool("gtc_firearms:golden_deagle_rld", {
	stack_max = 1,
	wield_scale = { x = 1.25, y = 1.25, z = 1.5 },
	description = "",
	range = 0,
	loaded_gun = "gtc_firearms:golden_deagle",
	groups = { not_in_creative_inventory = 1 },
	inventory_image = "rangedweapons_golden_deagle_rld.png",
})
core.register_tool("gtc_firearms:golden_deagle_r", {
	stack_max = 1,
	wield_scale = { x = 1.25, y = 1.25, z = 1.5 },
	description = "",
	range = 0,
	rw_next_reload = "gtc_firearms:golden_deagle",
	load_sound = "rangedweapons_handgun_mag_in",
	groups = { not_in_creative_inventory = 1 },
	inventory_image = "rangedweapons_golden_deagle_rld.png",
})

core.register_tool("gtc_firearms:golden_deagle", {
	description = ""
		.. core.colorize("#35cdff", "Golden Desert Eagle\n")
		.. core.colorize("#FFFFFF", "Ranged damage: 14\n")
		.. core.colorize("#FFFFFF", "Accuracy: 90%\n")
		.. core.colorize("#FFFFFF", "knockback: 6\n")
		.. core.colorize("#FFFFFF", "Critical chance: 23%\n")
		.. core.colorize("#FFFFFF", "Critical efficiency: 3x\n")
		.. core.colorize("#FFFFFF", "Reload delay: 0.6\n")
		.. core.colorize("#FFFFFF", "Clip size: 9/8/7\n")
		.. core.colorize("#FFFFFF", "Ammunition: .357 Magnum rounds/.44 magnum rounds/.50AE catridges\n")
		.. core.colorize("#FFFFFF", "Rate of fire: 0.75\n")
		.. core.colorize("#FFFFFF", "Gun type: Magnum\n")
		.. core.colorize("#FFFFFF", "Block penetration: 5%\n")
		.. core.colorize("#FFFFFF", "penetration: 15%\n")
		.. core.colorize("#FFFFFF", "Bullet velocity: 50"),
	wield_scale = { x = 1.25, y = 1.25, z = 1.5 },
	range = 0,
	inventory_image = "rangedweapons_golden_deagle.png",
	RW_gun_capabilities = {
		gun_damage = { fleshy = 14, knockback = 6 },
		gun_crit = 23,
		gun_critEffc = 2.2,
		suitable_ammo = { { "gtc_firearms:357", 9 }, { "gtc_firearms:44", 8 }, { "gtc_firearms:50ae", 7 } },
		gun_skill = { "revolver_skill", 38 },
		gun_magazine = "gtc_firearms:handgun_mag_white",
		gun_unloaded = "gtc_firearms:golden_deagle_r",
		gun_cooling = "gtc_firearms:golden_deagle_rld",
		gun_velocity = 50,
		gun_accuracy = 90,
		gun_cooldown = 0.75,
		gun_reload = 0.6 / 1,
		gun_projectiles = 1,
		has_shell = 1,
		gun_durability = 1000,
		gun_smokeSize = 7,
		gun_mob_penetration = 15,
		gun_node_penetration = 5,
		gun_unload_sound = "rangedweapons_handgun_mag_out",
		gun_sound = "rangedweapons_deagle",
	},
	on_secondary_use = function(itemstack, user, pointed_thing)
		rangedweapons_reload_gun(itemstack, user)
		return itemstack
	end,
	on_use = function(itemstack, user, pointed_thing)
		rangedweapons_shoot_gun(itemstack, user)
		return itemstack
	end,
})
