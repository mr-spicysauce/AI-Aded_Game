extends Control

onready var Global = get_node("/root/Globals")

var ammo =0
var max_ammo = null
var is_reloading = false

var avalibale_pistol_ammo = 32
var avalibale_rifle_ammo = 0
var avalibale_shotgun_ammo = 0
var avalibale_sniper_ammo = 0
var ammo_type = null
var ammo_take_away

func _physics_process(delta):
	
	if Global.is_holding_gun == true:
		self.show()
	else:
		self.hide()
	
	ammo = clamp(ammo, 0, 999)
	avalibale_pistol_ammo = clamp(avalibale_pistol_ammo, 0, 999)
	avalibale_rifle_ammo = clamp(avalibale_rifle_ammo, 0, 999)
	avalibale_shotgun_ammo = clamp(avalibale_shotgun_ammo, 0, 999)
	avalibale_sniper_ammo = clamp(avalibale_sniper_ammo, 0, 999)
	
	max_ammo = Global.max_bullets
	
	if is_reloading == true:
		$"ColorRect/Label".text = str("Reloading")
	else:
		$"ColorRect/Label".text = str("Ammo = " + str(ammo) + " / " + str(max_ammo))
	
	$"ColorRect/Label2".text = str(str(Global.gun_type) + " Ammo = " + str(ammo_type))
	
	if Input.is_action_just_pressed("left_click") and Global.Is_in_esc_menu == false and Global.is_holding_gun == true:
		ammo += -1
	
	if Input.is_action_just_pressed("Reload") and Global.is_holding_gun == true and ammo < max_ammo:
		is_reloading = true
		$"Reload timer".wait_time = Global.reload_time
		$"Reload timer".start()
	
	if Global.gun_type == "pistol":
		ammo_type = avalibale_pistol_ammo
	
	if Global.gun_type == "rifle":
		ammo_type = avalibale_rifle_ammo
	
	if Global.gun_type == "shotgun":
		ammo_type = avalibale_shotgun_ammo
	
	if Global.gun_type == "sniper":
		ammo_type = avalibale_sniper_ammo
	
	if ammo == 0:
		Global.has_bullet = false
	else:
		Global.has_bullet = true
		

func _on_Reload_timer_timeout():
	
	ammo_take_away = max_ammo - ammo
	if Global.gun_type == "pistol":
		if avalibale_pistol_ammo > ammo_take_away:
			avalibale_pistol_ammo -= ammo_take_away
			ammo = max_ammo
		elif avalibale_pistol_ammo > 0:
			ammo = ammo + avalibale_pistol_ammo
			avalibale_pistol_ammo -= avalibale_pistol_ammo
	
		ammo_take_away = max_ammo - ammo
	if Global.gun_type == "rifle":
		if avalibale_rifle_ammo > ammo_take_away:
			avalibale_rifle_ammo -= ammo_take_away
			ammo = max_ammo
		elif avalibale_rifle_ammo > 0:
			ammo = ammo + avalibale_rifle_ammo
			avalibale_rifle_ammo -= avalibale_rifle_ammo
	
		ammo_take_away = max_ammo - ammo
	if Global.gun_type == "shotgun":
		if avalibale_shotgun_ammo > ammo_take_away:
			avalibale_shotgun_ammo -= ammo_take_away
			ammo = max_ammo
		elif avalibale_shotgun_ammo > 0:
			ammo = ammo + avalibale_shotgun_ammo
			avalibale_shotgun_ammo -= avalibale_shotgun_ammo
	
		ammo_take_away = max_ammo - ammo
	if Global.gun_type == "sniper":
		if avalibale_sniper_ammo > ammo_take_away:
			avalibale_sniper_ammo -= ammo_take_away
			ammo = max_ammo
		elif avalibale_sniper_ammo > 0:
			ammo = ammo + avalibale_sniper_ammo
			avalibale_sniper_ammo -= avalibale_sniper_ammo
	
	is_reloading = false
