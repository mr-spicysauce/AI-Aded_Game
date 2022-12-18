extends StaticBody

onready var globals = get_node("/root/Globals")

func _on_Area_body_entered(body):
	if body.name == "Player" and globals.player_on_ladder == false:
		globals.player_on_ladder = true
		print("on ladder")

func _on_Area_body_exited(body):
	if body.name == "Player" and globals.player_on_ladder == true:
		globals.player_on_ladder = false
		print("off ladder")
