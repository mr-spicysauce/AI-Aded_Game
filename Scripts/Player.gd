extends KinematicBody

# Declare variables for movement speed and deceleration
var speed = 250
var deceleration = 0.9

# Spatial node containing the "head" object
export(NodePath) onready var head = get_node("head") as Spatial

#
export(NodePath) onready var wall_run_time_out = get_node("wall_run time out") as Timer

# Sensitivity of character movement
var sensitivity = 0.1

# Declare a variable to store the current velocity of the player
var velocity = Vector3()

# Gravitational acceleration applied to the character
const base_gravity = -150

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
var WALL_RUN_DURATION = 2

#
var object_on_left = false

#
var object_on_right = false

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
	
	var aim = head.get_global_transform().basis
	var forward = -aim.z
	var backward = aim.z
	var left = -aim.x
	var right = aim.x
	
	if Input.is_action_pressed("ui_up"):
		# If it is, increase the velocity in the forward direction
		velocity += Vector3(forward.x, 0, forward.z) * speed * delta
	if Input.is_action_pressed("ui_up") and global_vars.player_on_ladder == true:
		velocity += Vector3(forward.x, 1, forward.z) * speed * delta


	if Input.is_action_pressed("ui_down"):
		# If it is, increase the velocity in the forward direction
		velocity += Vector3(backward.x, 0, backward.z) * speed * delta

	if Input.is_action_pressed("ui_right"):
		# If it is, increase the velocity in the forward direction
		velocity += right * speed * delta

	if Input.is_action_pressed("ui_left"):
		# If it is, increase the velocity in the forward direction
		velocity += left * speed * delta

### I have no idea why but I need this here so code does break###
	if Input.is_action_pressed("ui_end"):
		# If it is, increase the velocity in the forward direction
		velocity += Vector3(0, 0, 0) * speed * delta

	# Check if the player is pressing the jump button and is on the ground
	if Input.is_action_just_pressed("jump") and is_on_floor():
		# If so, add the jump strength to the player's velocity
		velocity.y += jump_strength
	if Input.is_action_just_pressed("jump") and object_on_right and on_floor == false:
		velocity += Vector3(left.x, 0.4, left.z) * speed * 0.5
		velocity += Vector3(forward.x, 0, forward.z) * speed * 0.15
	if Input.is_action_just_pressed("jump") and object_on_left and on_floor == false:
		velocity += Vector3(right.x, 0.4, right.z) * speed * 0.5
		velocity += Vector3(forward.x, 0, forward.z) * speed * 0.15


	else:
		# If it is not, apply deceleration to the velocity
		velocity *= deceleration
	
	if is_on_floor():
		on_floor = true
	else:
		on_floor = false
	
	if on_floor == false and on_wall == false:
		gravity += base_gravity * 1.5 * delta
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

func _on_Left_collision_body_entered(body):
	object_on_left = true

func _on_Left_collision_body_exited(body):
	object_on_left = false
