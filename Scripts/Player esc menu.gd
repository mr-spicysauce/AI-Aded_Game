extends Control

onready var globals = get_node("/root/Globals")

var Is_in_esc_menu = false

func _physics_process(delta):
	if Input.is_action_just_pressed("esc menu"):
		if Is_in_esc_menu == false:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Is_in_esc_menu = true
			globals.Is_in_esc_menu = true

func _on_quit_pressed():
	Is_in_esc_menu = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	globals.Is_in_esc_menu = false
