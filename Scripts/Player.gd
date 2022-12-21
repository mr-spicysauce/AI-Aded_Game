extends KinematicBody

# Declare variables for movement speed and deceleration
var speed = 230

var base_deceleration = 0.9

var deceleration = 0.9

# Spatial node containing the "head" object
export(NodePath) onready var head = get_node("head") as Spatial

#
export(NodePath) onready var wall_run_time_out = get_node("wall_run time out") as Timer

#
export(NodePath) onready var slide_time_out = get_node("Slide_time time out") as Timer

#
onready var Collisionshape = get_node("CollisionShape") as CollisionShape

#
onready var CrouchingCollision = get_node("CrouchingCollision") as CollisionShape

#
onready var speedparticals = get_node("head/SpeedParticals")

# Sensitivity of character movement
var sensitivity = 0.1

# Declare a variable to store the current velocity of the player
var velocity = Vector3()

# Gravitational acceleration applied to the character
var base_gravity = -77

#
var gravity = -50

# Add a jump strength variable
var jump_strength = 100

#
var can_wall_run = true

# 
var on_wall = false

#
var on_floor = false

# The time spent running on a wall
var wall_run_time = 0

#
var WALL_RUN_DURATION = 1

#
var object_on_left = false

#
var object_on_right = false

#
var slide_speed = 0.01

#
var is_sliding = false

#
var can_slide = true

#
var slide_time = 0

#
var slide_duration = 0.5

#
var is_crouching

# The intensity of the camera shake
var shake_intensity = 0.25

# A timer to control the duration of the shake
var shake_timer = 0

# The maximum duration of the shake, in seconds
var shake_duration = 0.05

var shake = false

#
onready var global_vars = get_node("/root/Globals")

# Called when the script is first run
func _ready():
	# Set the mouse mode to captured, so that it is hidden and
	# the movement is relative to the screen
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

# Check if the player is currently wall running
func is_wall_running():
	return wall_run_time > 0

# Update the wall run time
func update_wall_run_time(delta):
	if is_wall_running():
		wall_run_time -= delta
		if wall_run_time < 0:
			wall_run_time = 0

func _physics_process(delta):
	deceleration = clamp(deceleration, base_deceleration, 0.94)
	var aim = head.get_global_transform().basis
	var forward = -aim.z
	var backward = aim.z
	var left = -aim.x
	var right = aim.x
	
	if Input.is_action_pressed("ui_up") and is_sliding == false:
		# If it is, increase the velocity in the forward direction
		velocity += Vector3(forward.x, 0, forward.z) * speed * delta
	if Input.is_action_pressed("ui_up") and global_vars.player_on_ladder == true and is_sliding == false:
		velocity += Vector3(forward.x, 1, forward.z) * speed * delta

	if Input.is_action_pressed("ui_down") and is_sliding == false:
		# If it is, increase the velocity in the forward direction
		velocity += Vector3(backward.x, 0, backward.z) * speed * delta

	if Input.is_action_pressed("ui_right") and is_sliding == false:
		# If it is, increase the velocity in the forward direction
		velocity += right * speed * delta

	if Input.is_action_pressed("ui_left") and is_sliding == false:
		# If it is, increase the velocity in the forward direction
		velocity += left * speed * delta

### I have no idea why but I need this here so code does break###
	if Input.is_action_pressed("ui_end"):
		# If it is, increase the velocity in the forward direction
		velocity += Vector3(0, 0, 0) * speed * delta

	# Check if the player is pressing the jump button and is on the ground
	if Input.is_action_just_pressed("jump") and is_on_floor() and is_sliding == false:
		# If so, add the jump strength to the player's velocity
		velocity.y += jump_strength
	if Input.is_action_just_pressed("jump") and object_on_right and on_floor == false and is_sliding == false:
		velocity += Vector3(left.x, 0.4, left.z) * speed * 0.35
		velocity += Vector3(forward.x, 0, forward.z) * speed * 0.15
	if Input.is_action_just_pressed("jump") and object_on_left and on_floor == false and is_sliding == false:
		velocity += Vector3(right.x, 0.4, right.z) * speed * 0.35
		velocity += Vector3(forward.x, 0, forward.z) * speed * 0.15
	var int_velocity = abs(velocity.x) + abs(velocity.z)
	if Input.is_action_pressed("Ctrl") and on_floor == true and int_velocity >35 and can_slide == true and is_crouching == false:
		is_sliding = true
		slide_time += delta
		slide_time_out.start()
	else:
		is_sliding = false
		slide_time = 0
	if slide_time > slide_duration:
		slide_time = 0
		is_sliding = false
		can_slide = false
		slide_time_out.start()
	
	if is_sliding == true:
		velocity += Vector3(forward.x, 0, forward.z) * speed * delta
		deceleration = deceleration + slide_speed
		Collisionshape.disabled = true
		CrouchingCollision.disabled = false
		head.translation = $CrouchHeadpos.transform.origin
		$"Partical holder/SlidingParticals".emitting = true
		speedparticals.emitting = true
	
	if is_sliding == false:
		deceleration = base_deceleration
		Collisionshape.disabled = false
		CrouchingCollision.disabled = true
		head.translation = $Headpos.transform.origin
		$"Partical holder/SlidingParticals".emitting = false
		speedparticals.emitting = false
	
	if Input.is_action_pressed("Ctrl") and is_sliding == false:
		is_crouching = true
	else:
		is_crouching = false
	
	if is_crouching == true:
		head.translation = $CrouchHeadpos.transform.origin
		Collisionshape.disabled = true
		CrouchingCollision.disabled = false
	elif is_sliding == false:
		head.translation = $Headpos.transform.origin
		Collisionshape.disabled = false
		CrouchingCollision.disabled = true
	
	velocity *= deceleration
	
	if is_on_floor():
		on_floor = true
	else:
		on_floor = false
	
	if on_floor == false and on_wall == false:
		gravity += base_gravity * 10 * delta
	else:
		gravity = base_gravity
	
	# Apply gravity to the player's velocity
	if global_vars.player_on_ladder == false:
		velocity.y += gravity * delta
	
	global_vars.player_velocity = velocity
	
	# Move the player by the current velocity
	move_and_slide(velocity, Vector3.UP)
	
	global_vars.player_pos = global_transform.origin
	
	# check if player is on wall
	if on_wall and on_wall == true:
	# increment wall run time
		wall_run_time += delta
	# check if wall run time has exceeded the maximum duration
	if wall_run_time > WALL_RUN_DURATION:
	  # reset wall run time and set on_wall to false
		wall_run_time = 0
		on_wall = false
		can_wall_run = false
		wall_run_time_out.start()
	
		# check for wall collision
	if is_on_wall() and can_wall_run == true and object_on_left == true or is_on_wall() and can_wall_run == true and object_on_right == true:
		 # set on_wall to true and reset wall run time
		on_wall = true
		 # adjust player's velocity to allow for wall running
		velocity.y = 0
	else:
		on_wall = false
		wall_run_time = 0
		head.rotation_degrees.z = 0
	
	if shake == true:
		shake()

func _on_Slide_time_time_out_timeout():
	can_slide = true

func _on_wall_run_time_out_timeout():
	can_wall_run = true


func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		# Rotate the player around the y-axis based on the mouse movement
		rotate_y(deg2rad(-event.relative.x * sensitivity))

		# Rotate the player's head around the x-axis based on the mouse movement, reversing the direction of the y-axis
		head.rotate_x(deg2rad(-event.relative.y * sensitivity))

		# Clamp the x-axis rotation of the player's head to prevent it from rotating too far
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

#####This set of functions will help with detecting if there is a object to the left or right#####
func _on_Right_collision_body_entered(body):
	object_on_right = true

func _on_Right_collision_body_exited(body):
	object_on_right = false
	if can_wall_run == true and on_wall == true:
		head.rotation_degrees.z = 0

func _on_Left_collision_body_entered(body):
	object_on_left = true

func _on_Left_collision_body_exited(body):
	object_on_left = false

func _on_Player_esc_menu_update_dev_settings():
	speed = global_vars.player_speed
	deceleration = global_vars.player_deceleration
	sensitivity = global_vars.player_mouse_sensitivity
	base_gravity = global_vars.player_base_gravity
	jump_strength = global_vars.player_jump_strength
	
	print(speed)
	print(deceleration)
	print(sensitivity)
	print(base_gravity)
	print(jump_strength)

func shake():
	print("shake")
	# Apply a random displacement to the camera's position, based on the intensity
	head.translate(Vector3(rand_range(-shake_intensity, shake_intensity), rand_range(-shake_intensity, shake_intensity), 0))
	# Increment the timer
	
	shake_timer += get_process_delta_time()
	# If the shake has reached the maximum duration, stop shaking
	if shake_timer >= shake_duration:
		shake_timer = 0
		shake = false

func _on_glass_thing_player_smash_glass():
	shake = true
