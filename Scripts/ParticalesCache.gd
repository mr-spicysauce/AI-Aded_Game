extends Spatial

onready var SpeedParticales = preload("res://Materials/Speed particasls.tres")
onready var Basicwhite = preload("res://Materials/Basic white.tres")

var materials = [
	SpeedParticales,
	Basicwhite,
]

func _ready():
	for material in materials:
		var particles_instance = Particles.new()
		particles_instance.set_process_material(material)
		particles_instance.set_one_shot(true)
		#particles_instance.set_modulate(Color(1,1,1,0))
		particles_instance.set_emitting(true)
		self.add_child(particles_instance)
