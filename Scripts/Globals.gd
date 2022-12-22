extends Node

var test = 5
var player_velocity
var player_pos #(vector 3)
var Is_in_esc_menu = false
var player_on_ladder = false
var spawn_pos
var has_bullet = false
var player_rotation

#vars for dev settings menu#
var player_speed= 480
var player_deceleration = 0.9
var player_mouse_sensitivity = 0.1
var player_base_gravity = -154
var player_jump_strength = 200

#gun vars

var ammo = 0

var max_bullets = 12
var fire_rate = null
var damage = null
var gun_type = null
var is_auto_gun = null

var current_pistol_ammo = 0
var current_rifle_ammo = 0
var current_shotgun_ammo = 0
var current_sniper_ammo = 0

var avalibale_pistol_ammo = 64
var avalibale_rifle_ammo = 90
var avalibale_shotgun_ammo = 0
var avalibale_sniper_ammo = 0

var reload_time = null

#Inventory vars
var currently_holding = null

var Slot_1_selected = false
var Slot_2_selected = false
var Slot_3_selected = false
var Slot_4_selected = false

var Item_In_slot_1 = false
var Item_In_slot_2 = false
var Item_In_slot_3 = false
var Item_In_slot_4 = false

var Item_ID_in_slot_1 = null
var Item_ID_in_slot_2 = null
var Item_ID_in_slot_3 = null
var Item_ID_in_slot_4 = null

# holding what
var is_holding_gun = false

# All item IDs
var ID_place_holder = "ID_place_holder3453453"
var ID_1 = "ID_1"
var ID_2 = "ID_2"

#All item IDs put into array
var ItemID = [
	 ID_1,
	 ID_2,
]

#All item ID's that are guns
var GunItemID = [
	ID_place_holder,
	ID_1,
	ID_2,
	ID_place_holder,
]

var pistolGun = [
	ID_1,
]

var rifleGun = [
	ID_2,
]

var shotgunGun = [
	
]

var sniper = [
	
]
