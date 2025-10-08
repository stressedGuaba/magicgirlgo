extends PanelContainer

@export var item : Weapon:
	set(value):
		item = value
		## update TextureRect & wait time for timer
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown
		item.slot = self
		

func _on_cooldown_timeout():
	## with each timeout, call activate from weapon
	if item:
		$Cooldown.wait_time = item.cooldown
		item.activate(owner, owner.nearest_enemy, get_tree())
		
