core.register_tool("gtc_firearms:awp_uld", {
	stack_max = 1,
	wield_scale = { x = 1.9, y = 1.9, z = 1.1 },
	range = 0,
	description = ""
		.. core.colorize("#35cdff", "A.W.P. \n")
		.. core.colorize("#FFFFFF", "Ranged damage:18 + 35/sec of bullet lifetime\n")
		.. core.colorize("#FFFFFF", "Accuracy: 100%\n")
		.. core.colorize("#FFFFFF", "knockback: 15\n")
		.. core.colorize("#FFFFFF", "Critical chance: 30%\n")
		.. core.colorize("#FFFFFF", "Critical efficiency: x3\n")
		.. core.colorize("#FFFFFF", "Ammunition: 7.62mm round/308.Winchester rounds\n")
		.. core.colorize("#FFFFFF", "Rate of fire: 1.0\n")
		.. core.colorize("#FFFFFF", "Reload time: 2.0\n")
		.. core.colorize("#FFFFFF", "Zoom: 12x\n")
		.. core.colorize("#be0d00", "Right-click to eject empty bullet shell\n")
		.. core.colorize("#FFFFFF", "Clip size: 10/10\n")
		.. core.colorize("#FFFFFF", "Enemy penetration:30%\n")
		.. core.colorize("#FFFFFF", "Block penetration:10%\n")
		.. core.colorize("#FFFFFF", "Gun type: Rifle\n")
		.. core.colorize("#FFFFFF", "Bullet velocity: 75"),
	groups = { not_in_creative_inventory = 1 },
	inventory_image = "rangedweapons_awp.png",
	weapon_zoom = 7.5,
	on_use = function(itemstack, user)
		core.sound_play("rangedweapons_empty", { pos = user:get_pos() }, true)
	end,
	on_secondary_use = function(itemstack, user, pointed_thing)
		eject_shell(
			itemstack,
			user,
			"gtc_firearms:awp_rld",
			1.0,
			"rangedweapons_rifle_reload_a",
			"gtc_firearms:empty_shell"
		)
		return itemstack
	end,
})

core.register_tool("gtc_firearms:awp_r", {
	rw_next_reload = "gtc_firearms:awp_rr",
	load_sound = "rangedweapons_rifle_clip_in",
	range = 0,
	wield_scale = { x = 1.9, y = 1.9, z = 1.1 },
	description = "",
	groups = { not_in_creative_inventory = 1 },
	inventory_image = "rangedweapons_awp_noclip.png",
})
core.register_tool("gtc_firearms:awp_rr", {
	rw_next_reload = "gtc_firearms:awp_rrr",
	load_sound = "rangedweapons_rifle_reload_a",
	range = 0,
	wield_scale = { x = 1.9, y = 1.9, z = 1.1 },
	description = "",
	groups = { not_in_creative_inventory = 1 },
	inventory_image = "rangedweapons_awp.png",
})
core.register_tool("gtc_firearms:awp_rrr", {
	rw_next_reload = "gtc_firearms:awp",
	load_sound = "rangedweapons_rifle_reload_b",
	range = 0,
	wield_scale = { x = 1.9, y = 1.9, z = 1.1 },
	description = "",
	groups = { not_in_creative_inventory = 1 },
	inventory_image = "rangedweapons_awp_rld.png",
})

core.register_tool("gtc_firearms:awp_rld", {
	stack_max = 1,
	range = 0,
	wield_scale = { x = 1.9, y = 1.9, z = 1.1 },
	description = "",
	loaded_gun = "gtc_firearms:awp",
	loaded_sound = "rangedweapons_rifle_reload_b",
	groups = { not_in_creative_inventory = 1 },
	inventory_image = "rangedweapons_awp_rld.png",
})

core.register_tool("gtc_firearms:awp", {
	description = ""
		.. core.colorize("#35cdff", "A.W.P. \n")
		.. core.colorize("#FFFFFF", "Ranged damage:18 + 35/sec of bullet lifetime\n")
		.. core.colorize("#FFFFFF", "Accuracy: 100%\n")
		.. core.colorize("#FFFFFF", "knockback: 15\n")
		.. core.colorize("#FFFFFF", "Critical chance: 30%\n")
		.. core.colorize("#FFFFFF", "Critical efficiency: x3\n")
		.. core.colorize("#FFFFFF", "Ammunition: 7.62mm round/308.Winchester rounds\n")
		.. core.colorize("#FFFFFF", "Rate of fire: 1.0\n")
		.. core.colorize("#FFFFFF", "Reload time: 2.0\n")
		.. core.colorize("#FFFFFF", "Zoom: 12x\n")
		.. core.colorize("#27a600", "The gun is loaded!\n")
		.. core.colorize("#FFFFFF", "Clip size: 10/10\n")
		.. core.colorize("#FFFFFF", "Enemy penetration:30%\n")
		.. core.colorize("#FFFFFF", "Block penetration:10%\n")
		.. core.colorize("#FFFFFF", "Gun type: Rifle\n")
		.. core.colorize("#FFFFFF", "Bullet velocity: 75"),
	range = 0,
	weapon_zoom = 7.5,
	wield_scale = { x = 1.9, y = 1.9, z = 1.1 },
	inventory_image = "rangedweapons_awp.png",
	RW_gun_capabilities = {
		gun_damage = { fleshy = 18, knockback = 15 },
		gun_crit = 30,
		gun_critEffc = 3.0,
		suitable_ammo = { { "gtc_firearms:762mm", 10 }, { "gtc_firearms:308winchester", 10 } },
		gun_skill = { "rifle_skill", 20 },
		gun_magazine = "gtc_firearms:rifle_mag",
		gun_unloaded = "gtc_firearms:awp_r",
		gun_cooling = "gtc_firearms:awp_uld",
		gun_velocity = 75,
		gun_accuracy = 100,
		gun_cooldown = 1.0,
		gun_reload = 2.0 / 4,
		gun_projectiles = 1,
		has_shell = 0,
		gun_durability = 700,
		gun_smokeSize = 8,
		gun_dps = 35,
		gun_mob_penetration = 30,
		gun_node_penetration = 10,
		gun_unload_sound = "rangedweapons_rifle_clip_out",
		gun_sound = "rangedweapons_rifle_b",
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
