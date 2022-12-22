extends Spatial

func _on_Area_body_entered(body):
	if body.name == "Player":
		$"3d text".show()

func _on_Area_body_exited(body):
	if body.name == "Player":
		$"3d text".hide()

onready var text_pos = get_node("Gun_test ID_2")
onready var text = get_node("RigidBody/3d text")

func _physics_process(delta):
	var new_text_pos = text_pos.transform.origin
	new_text_pos.y = new_text_pos.y + 2
	$"3d text".translation = new_text_pos
