extends Spatial

onready var player = get_parent().get_parent().get_node("Player")

# Assume that `player` is the player object and `object` is the object that you want to trigger an action

var is_object_near = false

# Set the minimum speed that the player must have to trigger the action
var min_speed = 40

var distance

signal break_glass

export var BreakParticals: PackedScene = preload("res://game objects/Breaking glass particals.tscn")

var bullet = "Bullet"

func break_glass(velocity):
	if velocity.length() > min_speed and is_object_near == true:
		var brokeparticals := BreakParticals.instance()
		#get_parent().add_child(brokeparticals)
		emit_signal("break_glass")

func _on_Area_body_entered(body):
	if body.name == "Player":
		is_object_near = true
		print("object is near")
		var velocity = body.velocity
		print(velocity)
		break_glass(velocity)
	else:
		if bullet in body.name:
			is_object_near = true
			var velocity = Vector3(100,100,100)
			break_glass(velocity)
			pass
		else:
			if body.is_in_group("Can_break_glass"):
				is_object_near = true
				print("object is near")
				# Get the velocity of the body that entered the area
				var velocity = body.get_linear_velocity()
				velocity += velocity * 2
				print(velocity)
				print(body.name)
				break_glass(velocity)

func _on_Area_body_exited(body):
	is_object_near = false
