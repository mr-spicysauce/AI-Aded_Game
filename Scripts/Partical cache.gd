extends Spatial

func _ready():
	$SlidingParticals.emitting = true
	$SpeedParticals.emitting = true
	
	
	$Timer.start()

func _on_Timer_timeout():
	get_parent().get_parent().get_parent().get_node("UI holder").show()
	self.queue_free()
