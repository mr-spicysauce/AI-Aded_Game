extends RigidBody

onready var particals = $Bullet_particals
onready var Cshape = $CollisionShape

var bounce_amount = 0

func _ready():
	$Tween.interpolate_property($CollisionShape/MeshInstance, "scale", scale, scale * .01, randf() * 4, Tween.TRANS_LINEAR, Tween.EASE_IN, 4)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()

func _on_Bullet_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	particals.emitting = true
	bounce_amount += 1
	print(bounce_amount)
	if bounce_amount > 2:
		queue_free()
