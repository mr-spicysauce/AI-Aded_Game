extends Area

signal Is_on_right_wall

func _on_Right_collision_body_entered(body):
	print("is on the right")

func _on_Right_collision_body_exited(body):
	print("is no longer on the right")
