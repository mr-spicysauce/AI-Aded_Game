extends Control

onready var Global = get_node("/root/Globals")

var ammo = null
var max_ammo = null
var is_reloading = false

var ammo_type = null
var ammo_take_away

func _physics_process(delta):
	
	
	if Global.is_holding_gun == true:
		self.show()
	else:
		self.hide()
	
	Global.current_pistol_ammo = clamp(Global.current_pistol_ammo, 0, 999)
	Global.current_rifle_ammo = clamp(Global.current_rifle_ammo, 0, 999)
	Global.current_shotgun_ammo = clamp(Global.current_shotgun_ammo, 0, 999)
	Global.current_sniper_ammo = clamp(Global.current_sniper_ammo, 0, 999)
	
	Global.avalibale_pistol_ammo = clamp(Global.avalibale_pistol_ammo, 0, 999)
	Global.avalibale_rifle_ammo = clamp(Global.avalibale_rifle_ammo, 0, 999)
	Global.avalibale_shotgun_ammo = clamp(Global.avalibale_shotgun_ammo, 0, 999)
	Global.avalibale_sniper_ammo = clamp(Global.avalibale_sniper_ammo, 0, 999)
	
	max_ammo = Global.max_bullets
	
	if is_reloading == true:
		$"ColorRect/Label".text = str("Reloading")
	else:
		$"ColorRect/Label".text = str("Ammo = " + str(ammo) + " / " + str(max_ammo))
	
	$"ColorRect/Label2".text = str(str(Global.gun_type) + " Ammo = " + str(ammo_type))
	
	if Input.is_action_just_pressed("left_click") and Global.Is_in_esc_menu == false and Global.is_holding_gun == true:
		
		if Global.gun_type == "pistol":
			Global.current_pistol_ammo += -1
			print(Global.current_pistol_ammo)

		if Global.gun_type == "rifle":
			Global.current_rifle_ammo += -1
			print(Global.current_rifle_ammo)

		if Global.gun_type == "shotgun":
			Global.current_shotgun_ammo += -1
			print(Global.current_shotgun_ammo)

		if Global.gun_type == "sniper":
			Global.current_sniper_ammo += -1
			print(Global.current_sniper_ammo)

	if Input.is_action_just_pressed("Reload") and Global.is_holding_gun == true and ammo < max_ammo:
		is_reloading = true
		$"Reload timer".wait_time = Global.reload_time
		$"Reload timer".start()
	
	if Global.gun_type == "pistol":
		ammo_type = Global.avalibale_pistol_ammo
		ammo = Global.current_pistol_ammo
	
		if Global.current_pistol_ammo > 0:
			Global.has_bullet = true
		else:
			Global.has_bullet = false

	if Global.gun_type == "rifle":
		ammo_type = Global.avalibale_rifle_ammo
		ammo = Global.current_rifle_ammo

		if Global.current_rifle_ammo > 0:
			Global.has_bullet = true
		else:
			Global.has_bullet = false

	if Global.gun_type == "shotgun":
		ammo_type = Global.avalibale_shotgun_ammo
		ammo = Global.current_shotgun_ammo

		if Global.current_shotgun_ammo > 0:
			Global.has_bullet = true
		else:
			Global.has_bullet = false

	if Global.gun_type == "sniper":
		ammo_type = Global.avalibale_sniper_ammo
		ammo = Global.current_sniper_ammo

		if Global.current_sniper_ammo > 0:
			Global.has_bullet = true
		else:
			Global.has_bullet = false

#	if ammo == 0:
#		Global.has_bullet = false
#	else:
#		Global.has_bullet = true

func _on_Reload_timer_timeout():
	if Global.gun_type == "pistol":
		ammo_take_away = max_ammo - Global.current_pistol_ammo
		if Global.avalibale_pistol_ammo > ammo_take_away:
			Global.avalibale_pistol_ammo -= ammo_take_away
			Global.current_pistol_ammo = max_ammo
		elif Global.avalibale_pistol_ammo > 0:
			Global.current_pistol_ammo = Global.current_pistol_ammo + Global.avalibale_pistol_ammo
			Global.avalibale_pistol_ammo -= Global.avalibale_pistol_ammo
	
	if Global.gun_type == "rifle":
		ammo_take_away = max_ammo - Global.current_rifle_ammo
		if Global.avalibale_rifle_ammo > ammo_take_away:
			Global.avalibale_rifle_ammo -= ammo_take_away
			Global.current_rifle_ammo = max_ammo
		elif Global.avalibale_rifle_ammo > 0:
			Global.current_rifle_ammo = Global.current_rifle_ammo + Global.avalibale_rifle_ammo
			Global.avalibale_rifle_ammo -= Global.avalibale_rifle_ammo
	
	if Global.gun_type == "shotgun":
		ammo_take_away = max_ammo - Global.current_shotgun_ammo
		if Global.avalibale_shotgun_ammo > ammo_take_away:
			Global.avalibale_shotgun_ammo -= ammo_take_away
			Global.current_shotgun_ammo = max_ammo
		elif Global.avalibale_shotgun_ammo > 0:
			Global.current_shotgun_ammo = Global.current_shotgun_ammo + Global.avalibale_shotgun_ammo
			Global.avalibale_shotgun_ammo -= Global.avalibale_shotgun_ammo
	
	if Global.gun_type == "sniper":
		ammo_take_away = max_ammo - Global.current_sniper_ammo
		if Global.avalibale_sniper_ammo > ammo_take_away:
			Global.avalibale_sniper_ammo -= ammo_take_away
			Global.current_sniper_ammo = max_ammo
		elif Global.avalibale_sniper_ammo > 0:
			Global.current_sniper_ammo = Global.current_sniper_ammo + Global.avalibale_sniper_ammo
			Global.avalibale_sniper_ammo -= Global.avalibale_sniper_ammo
	
	is_reloading = false
