extends Node2D


var effects = {
	"dust" : load("res://Resources/Particles/dust.tres"), 
	"blood" : load("res://Resources/Particles/blood.tres")
}
var particle : PackedScene = preload("res://tscn/particle.tscn")

func add_effect(effect_name: String, pos: Vector2, parent: Node = null):
	if effect_name not in effects: 
		print("Effect % not found" % effect_name)
		return
	
	var effect = effects[effect_name]
	if parent == null:
		parent = get_tree().current_scene
	
	var particle_instance : GPUParticles2D = particle.instantiate()
	particle_instance.process_material = effect
	particle_instance.global_position = pos
	parent.add_child(particle_instance)
	
