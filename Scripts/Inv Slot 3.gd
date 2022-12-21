extends ColorRect

var Slot_3_selected = false

onready var Topoutline = get_node("Topoutline/Topoutline")
onready var Bottomoutline = get_node("Bottomoutline/Bottomoutline")
onready var Rightpoutline = get_node("Rightoutline/Rightoutline")
onready var Leftoutline = get_node("Leftoutline/Leftoutline")

func selected():
	Topoutline.color = "85b8fa"
	Bottomoutline.color = "85b8fa"
	Rightpoutline.color = "85b8fa"
	Leftoutline.color = "85b8fa"

func unselected():
	Topoutline.color = "b6b6b6"
	Bottomoutline.color = "b6b6b6"
	Rightpoutline.color = "b6b6b6"
	Leftoutline.color = "b6b6b6"

func _physics_process(delta):
	Slot_3_selected = get_parent().get_parent().get_parent().Slot_3_selected
	
	if Slot_3_selected == true:
		selected()
	elif Slot_3_selected == false:
		unselected()
