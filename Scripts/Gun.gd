extends Node

# Add a reference to the projectile prefab
onready var projectile_prefab = preload("res://Player/Bullet.tscn")
onready var globals = get_node("/root/Globals")
onready var Bullet_direction = get_parent().get_parent().get_node("Bullet direction")

var position

func _input(event):
	if  globals.Is_in_esc_menu == false and Input.is_action_just_pressed("left_click"):
		# Spawn the projectile
		var projectile = projectile_prefab.instance()
		projectile.translation = get_parent().global_transform.origin
		add_child(projectile)
		# Set the projectile's position to the player's position
		position = projectile.get_parent().get_parent().global_transform.origin
		# Set the projectile's velocity in the direction the player is facing
		var direction = Bullet_direction.global_transform.origin - position
		projectile.apply_central_impulse(direction * 200)
