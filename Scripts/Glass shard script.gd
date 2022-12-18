extends RigidBody

onready var global_vars = get_node("/root/Globals")

func _ready():
	
	var player_pos = global_vars.player_pos.normalized()
	var self_pos = self.global_transform.origin.normalized()
	
	# Calculate the vector pointing away from the player
	var away_vector = self_pos - player_pos
	
	# Normalize the vector to get a direction with a length of 1
	away_vector = away_vector.normalized()

	# Apply the impulse in the direction away from the player
	apply_impulse(Vector3(self_pos.x,0,self_pos.z), Vector3(away_vector.x ,0,away_vector.z) *20)

	$Tween.interpolate_property($MeshInstance, "scale", scale, scale * .01, randf() * 4, Tween.TRANS_LINEAR, Tween.EASE_IN, 4)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()
