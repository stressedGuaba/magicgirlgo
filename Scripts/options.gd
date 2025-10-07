extends VBoxContainer



@export var weapons : HBoxContainer
var OptionSlot = preload("res://tscn/option_slot.tscn")

@export var particles : GPUParticles2D
@export var panel : NinePatchRect


func _ready():
	hide()
	particles.hide()
	panel.hide()
	

func close_option():
	hide()
	particles.hide()
	panel.hide()
	get_tree().paused = false
	
func get_available_weapons():
	var weapon_resource = []
	for weapon in weapons.get_children():
		if weapon.weapon != null:
			weapon_resource.append(weapon.weapon)
	return weapon_resource

func show_option():
	var weapons_available = get_available_weapons()
	if weapons_available.size() == 0:
		return

	for slot in get_children():
		slot.queue_free()
	
	var option_size = 0
	
	for weapon in weapons_available:
		if weapon.is_upgradable():
			## add option for every weaponm available
			var option_slot = OptionSlot.instantiate()
			option_slot.weapon = weapon
			add_child(option_slot)
			option_size += 1
	
	if option_size == 0:
		return

	show()
	particles.show()
	panel.show()
	get_tree().paused = true
