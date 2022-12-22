extends Node

onready var globals = get_node("/root/Globals")

#var items = {
#"ID_1": preload("res://Pickup able objects/ID_1.tscn"),
#"ID_2": preload("res://Pickup able objects/AK47 ID_2.tscn"),
#}

var items = {
"ID_1": "res://Pickup able objects/ID_1 1.tscn",
"ID_2": "res://Pickup able objects/AK47 ID_2 1.tscn",
}

func _process(delta):
	
	for GunItemID in globals.GunItemID:
		var Guncheck = GunItemID
		if globals.currently_holding == Guncheck:
			globals.is_holding_gun = true
	
	if globals.currently_holding == null:
		globals.is_holding_gun = false
	
	#This checks to see what stats to give the gun.
	
	if globals.is_holding_gun == true:
		if globals.currently_holding == "ID_1":
			globals.gun_type = "pistol"
			globals.max_bullets = 16
			globals.fire_rate = 0.1
			globals.damage = 25
			globals.reload_time = 0.5
			globals.is_auto_gun = false

		if globals.currently_holding == "ID_2":
				globals.gun_type = "rifle"
				globals.max_bullets = 30
				globals.fire_rate = 0.1
				globals.damage = 65
				globals.reload_time = 1
				globals.is_auto_gun = true

	if Input.is_action_just_pressed("q"):
		
		if globals.is_holding_gun == true:
			
			if globals.gun_type == "pistol":
				globals.avalibale_pistol_ammo += globals.current_pistol_ammo
				globals.current_pistol_ammo = 0
			if globals.gun_type == "rifle":
				globals.avalibale_rifle_ammo += globals.current_rifle_ammo
				globals.current_rifle_ammo = 0
			if globals.gun_type == "shotgun":
				globals.avalibale_shotgun_ammo += globals.current_shotgun_ammo
				globals.current_shotgun_ammo = 0
			if globals.gun_type == "sniper":
				globals.avalibale_sniper_ammo += globals.current_sniper_ammo
				globals.current_sniper_ammo = 0

		if globals.Slot_1_selected == true:
			if globals.currently_holding in items:
				var resource_path = items[globals.currently_holding]
				print(resource_path)
				var path = ResourceLoader.load(resource_path)
				var item = path.instance()
				get_parent().get_parent().get_parent().get_parent().get_parent().add_child(item)
				item.translation = globals.spawn_pos
				item.transform.basis = Basis(Vector3(0,1,0) ,globals.player_rotation.y)
				globals.Item_In_slot_1 = false
				globals.Item_ID_in_slot_1 = null
				print("drop Item")

		if globals.Slot_2_selected == true:
			if globals.currently_holding in items:
				var resource_path = items[globals.currently_holding]
				print(resource_path)
				var path = ResourceLoader.load(resource_path)
				var item = path.instance()
				get_parent().get_parent().get_parent().get_parent().get_parent().add_child(item)
				item.translation = globals.spawn_pos
				globals.Item_In_slot_2 = false
				globals.Item_ID_in_slot_2 = null
				print("drop Item")

		if globals.Slot_3_selected == true:
			if globals.currently_holding in items:
				var resource_path = items[globals.currently_holding]
				print(resource_path)
				var path = ResourceLoader.load(resource_path)
				var item = path.instance()
				get_parent().get_parent().get_parent().get_parent().get_parent().add_child(item)
				item.translation = globals.spawn_pos
				globals.Item_In_slot_3 = false
				globals.Item_ID_in_slot_3 = null
				print("drop Item")

		if globals.Slot_4_selected == true:
			if globals.currently_holding in items:
				var resource_path = items[globals.currently_holding]
				print(resource_path)
				var path = ResourceLoader.load(resource_path)
				var item = path.instance()
				get_parent().get_parent().get_parent().get_parent().get_parent().add_child(item)
				item.translation = globals.spawn_pos
				globals.Item_In_slot_4 = false
				globals.Item_ID_in_slot_4 = null
				print("drop Item")
