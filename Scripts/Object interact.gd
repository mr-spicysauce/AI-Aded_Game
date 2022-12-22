extends Area

onready var globals = get_node("/root/Globals")

var can_pick_up = false
var pick_up_body
var is_on_list = false

var Item_ID_is 

func _on_Object_interact_body_entered(body):
	if body.is_in_group("Pick_add"):
		can_pick_up = true
		pick_up_body = body
		for item_id in globals.ItemID:
			var ID_check = item_id
			if str(ID_check) in body.name:
				Item_ID_is = ID_check
				is_on_list = true
				break

func _on_Object_interact_body_exited(body):
	if body.is_in_group("Pick_add"):
		can_pick_up = false
		pick_up_body = null
		is_on_list = false

func _process(delta):
	
	if globals.Slot_1_selected == true and globals.Item_In_slot_1 == false:
		if Input.is_action_just_pressed("E") and can_pick_up == true and is_on_list == true:
			globals.Item_ID_in_slot_1 = Item_ID_is
			globals.Item_In_slot_1 = true
			print("pick up gun")
			pick_up_body.get_parent().queue_free()

	if globals.Slot_2_selected == true and globals.Item_In_slot_2 == false:
		if Input.is_action_just_pressed("E") and can_pick_up == true and is_on_list == true:
			globals.Item_ID_in_slot_2 = Item_ID_is
			globals.Item_In_slot_2 = true
			print("pick up gun")
			pick_up_body.get_parent().queue_free()

	if globals.Slot_3_selected == true and globals.Item_In_slot_3 == false:
		if Input.is_action_just_pressed("E") and can_pick_up == true and is_on_list == true:
			globals.Item_ID_in_slot_3 = Item_ID_is
			globals.Item_In_slot_3 = true
			print("pick up gun")
			pick_up_body.get_parent().queue_free()

	if globals.Slot_4_selected == true and globals.Item_In_slot_4 == false:
		if Input.is_action_just_pressed("E") and can_pick_up == true and is_on_list == true:
			globals.Item_ID_in_slot_4 = Item_ID_is
			globals.Item_In_slot_4 = true
			print("pick up gun")
			pick_up_body.get_parent().queue_free()

