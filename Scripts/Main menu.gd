extends Control

# Declare a constant for the scene file for the main menu
const MAIN_MENU_SCENE = "res://Levels/main_menu.tscn"

# Declare a constant for the scene file for the game
const GAME_SCENE = ("res://Levels/Testing.tscn")
const test_lvl_1 = ("res://Levels/Test_lvl_1.tscn")
var GAME_SCENE_INSTANCE

# Declare variables for the start game button and quit game button
var start_game_button
var quit_game_button

# This function is called when the main menu is first displayed
func _ready():
	# Get the start game button and quit game button nodes
	start_game_button = get_node("StartGameButton")
	quit_game_button = get_node("QuitGameButton")
	
	# Connect the button clicked signals to the appropriate functions
	start_game_button.connect("pressed", self, "_on_start_game_button_pressed")
	quit_game_button.connect("pressed", self, "_on_quit_game_button_pressed")

# This function is called when the start game button is pressed
func _on_start_game_button_pressed():
	# Load the game scene
	get_tree().change_scene(GAME_SCENE)

# This function is called when the quit game button is pressed
func _on_quit_game_button_pressed():
	# Quit the game
	get_tree().quit()

func _on_OpenTestLvl1_pressed():
	get_tree().change_scene(test_lvl_1)
