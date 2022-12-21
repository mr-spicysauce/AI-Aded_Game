extends Node

onready var globals = get_node("/root/Globals")

func _process(delta):
	for GunItemID in globals.GunItemID:
		var Guncheck = GunItemID
		if globals.currently_holding == Guncheck:
			globals.is_holding_gun = true
		else:
			globals.is_holding_gun = false
	
	#This checks to see what stats to give the gun.
	
	if globals.is_holding_gun == true:
		if globals.currently_holding == "ID_1":
			globals.gun_type = "pistol"
			globals.max_bullets = 8
			globals.fire_rate = 0.1
			globals.damage = 25
			globals.reload_time = 0.5


	if Input.is_action_just_pressed("q"):
		var ID_1 = preload("res://Pickup able objects/ID_1.tscn")
		ID_1 = ID_1.instance()
		
		if globals.Slot_1_selected == true:
			if globals.currently_holding == "ID_1":
				get_parent().get_parent().get_parent().get_parent().get_parent().add_child(ID_1)
			globals.Item_In_slot_1 = false
			globals.Item_ID_in_slot_1 = null
			print("drop Item")

		if globals.Slot_2_selected == true:
			if globals.currently_holding == "ID_1":
				get_parent().get_parent().get_parent().get_parent().get_parent().add_child(ID_1)
			globals.Item_In_slot_2 = false
			globals.Item_ID_in_slot_2 = null
			print("drop Item")

		if globals.Slot_3_selected == true:
			if globals.currently_holding == "ID_1":
				get_parent().get_parent().get_parent().get_parent().get_parent().add_child(ID_1)
			globals.Item_In_slot_3 = false
			globals.Item_ID_in_slot_3 = null
			print("drop Item")

		if globals.Slot_4_selected == true:
			if globals.currently_holding == "ID_1":
				get_parent().get_parent().get_parent().get_parent().get_parent().add_child(ID_1)
			globals.Item_In_slot_4 = false
			globals.Item_ID_in_slot_4 = null
			print("drop Item")
