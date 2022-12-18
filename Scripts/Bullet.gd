extends RigidBody

onready var Cshape = $CollisionShape

func _ready():
	$Tween.interpolate_property($CollisionShape/MeshInstance, "scale", scale, scale * .01, randf() * 4, Tween.TRANS_LINEAR, Tween.EASE_IN, 4)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()
