extends Spatial

onready var globals = get_node("/root/Globals")

func _process(delta):
	if globals.currently_holding == "ID_1":
		$Glock17.show()
		if Input.is_action_just_pressed("Reload"):
			$Glock17/AnimationPlayer.play("Reload")
		
		if globals.has_bullet == false:
			$Glock17/Glock17/Slide.translation = Vector3(0,0.9,0)
	else:
		$Glock17.hide()
	
	if globals.currently_holding == "ID_2":
		$"AK47_mesh+anim".show()
		
		if globals.has_bullet == false:
			$"AK47_mesh+anim/Slider_low".translation = Vector3(0.136,0.12,0.003)
	else:
		$"AK47_mesh+anim".hide()

func _on_Gun_shot_fired():
	if globals.currently_holding == "ID_1":
		$Glock17/AnimationPlayer.play("Shoot gun")
	if globals.currently_holding == "ID_2":
		$"AK47_mesh+anim/AnimationPlayer".play("Shoot gun")
