extends Control

onready var globals = get_node("/root/Globals")
onready var player_speed_edit = $"Dev settings/Player speed/Player_speed_edit"
onready var player_deceleration_edit = $"Dev settings/Player deceleration/Player deceleration edit"
onready var player_jump_strength_edit = $"Dev settings/player jump strength/player jump strength edit"
onready var player_mouse_sensitivity_edit = $"Dev settings/player mouse sens/player mouse sens edit"
onready var player_base_gravity_edit = $"Dev settings/player gravity/player gravity edit"
onready var max_ammo_edit = $"Dev settings/Max ammo/Max ammo edit"

var Is_in_esc_menu = false

signal update_dev_settings

func _physics_process(delta):
	if Input.is_action_just_pressed("esc menu"):
		if Is_in_esc_menu == false:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			self.show()
			Is_in_esc_menu = true
			globals.Is_in_esc_menu = true

func _on_quit_pressed():
	self.hide()
	Is_in_esc_menu = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	globals.Is_in_esc_menu = false

func _on_dev_settings_pressed():
	$"Main page".hide()
	$"Dev settings".show()

func _on_Back_to_main_page_pressed():
	$"Main page".show()
	$"Dev settings".hide()

func _on_Update_settings_pressed():
	globals.player_speed = int(player_speed_edit.get_text())
	globals.player_deceleration = float(player_deceleration_edit.get_text())
	globals.player_mouse_sensitivity = float(player_mouse_sensitivity_edit.get_text())
	globals.player_base_gravity = int(player_base_gravity_edit.get_text())
	globals.player_jump_strength = int(player_jump_strength_edit.get_text())
	globals.max_bullets = int(max_ammo_edit.get_text())
	emit_signal("update_dev_settings")

func _on_quit_game_pressed():
	get_tree().quit()
