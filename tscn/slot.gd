extends PanelContainer

@export var weapon : Weapon:
	set(value):
		weapon = value
		## update TextureRect & wait time for timer
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown
		
		

func _on_cooldown_timeout() -> void:
	## with each timeout, call activate from weapon
	if weapon:
		$Cooldown.wait_time = weapon.cooldown
		weapon.activate(owner, owner.nearest_enemy, get_tree())
		
