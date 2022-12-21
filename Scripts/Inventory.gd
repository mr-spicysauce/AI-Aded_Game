extends Control

onready var gloabls = get_node("/root/Globals")

var Slot_1_selected = false
var Slot_2_selected = false
var Slot_3_selected = false
var Slot_4_selected = false

var Item_In_slot_1 = false
var Item_In_slot_2 = false
var Item_In_slot_3 = false
var Item_In_slot_4 = false

func _physics_process(delta):
	
	#print("curremtly_holding " + str(gloabls.currently_holding))
	#print("is slot 1 slected " + str(gloabls.Slot_1_selected))
	#print("Is item in slot 1 " + str(gloabls.Item_In_slot_1))
	#print(gloabls.is_holding_gun)
	
	Item_In_slot_1 = gloabls.Item_In_slot_1
	Item_In_slot_2 = gloabls.Item_In_slot_2
	Item_In_slot_3 = gloabls.Item_In_slot_3
	Item_In_slot_4 = gloabls.Item_In_slot_4
	
	if Input.is_action_just_pressed("1") and Slot_1_selected:
		Slot_1_selected = false
	elif Input.is_action_just_pressed("1"):
		Slot_1_selected = true
		Slot_2_selected = false
		Slot_3_selected = false
		Slot_4_selected = false
	if Input.is_action_just_pressed("2") and Slot_2_selected:
		Slot_2_selected = false
	elif Input.is_action_just_pressed("2"):
		Slot_1_selected = false
		Slot_2_selected = true
		Slot_3_selected = false
		Slot_4_selected = false
	if Input.is_action_just_pressed("3") and Slot_3_selected:
		Slot_3_selected = false
	elif Input.is_action_just_pressed("3"):
		Slot_1_selected = false
		Slot_2_selected = false
		Slot_3_selected = true
		Slot_4_selected = false
	if Input.is_action_just_pressed("4") and Slot_4_selected:
		Slot_4_selected = false
	elif Input.is_action_just_pressed("4"):
		Slot_1_selected = false
		Slot_2_selected = false
		Slot_3_selected = false
		Slot_4_selected = true
	
	gloabls.Slot_1_selected = Slot_1_selected
	gloabls.Slot_2_selected = Slot_2_selected
	gloabls.Slot_3_selected = Slot_3_selected
	gloabls.Slot_4_selected = Slot_4_selected

	if gloabls.Item_In_slot_1 == true and gloabls.Slot_1_selected == true:
		gloabls.currently_holding = gloabls.Item_ID_in_slot_1
	elif gloabls.Item_In_slot_2 == true and gloabls.Slot_2_selected == true:
		gloabls.currently_holding = gloabls.Item_ID_in_slot_2
	elif gloabls.Item_In_slot_3 == true and gloabls.Slot_3_selected == true:
		gloabls.currently_holding = gloabls.Item_ID_in_slot_3
	elif gloabls.Item_In_slot_4 == true and gloabls.Slot_4_selected == true:
		gloabls.currently_holding = gloabls.Item_ID_in_slot_4
	else:
		gloabls.currently_holding = null
