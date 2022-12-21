extends Spatial

onready var globals = get_node("/root/Globals")

func _process(delta):
	
	print(get_children())
	
	for GunItemID in globals.GunItemID:
		var Guncheck = GunItemID
		if globals.currently_holding == Guncheck:
			globals.is_holding_gun = true
		else:
			globals.is_holding_gun = false
