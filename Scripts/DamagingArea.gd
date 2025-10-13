extends Weapon
class_name DamagingArea

@export var angular_speed : float = 10
@export var area : float = 0.5

var angle : float
var projectile_reference

func activate(source, _target, _scene_tree):
	## upload sound to forcefield.tres when get chance
	## SoundManager.play_sfx(sound)
	reset_collision()
	pulsate(_scene_tree)
	
	if not projectile_reference:
		add_to_player(source)

func update(delta):
	angle += angular_speed * delta
	if is_instance_valid(projectile_reference):
		projectile_reference.rotation_degrees = angle
		projectile_reference.damage = damage

func reset():
	## defning a reset function that will free the projectile node
	if is_instance_valid(projectile_reference):
		projectile_reference.queue_free()

func add_to_player(source):
	var projectile = projectile_node.instantiate()
	projectile.speed = 0
	projectile.damage = damage
	projectile.source = source
	projectile.scale = Vector2(area, area)
	projectile.z_index = 0

	projectile.find_child("Sprite2D").texture = texture
	projectile.find_child("CollisionShape2D").shape.radius = 90
	projectile.knockback = -40
	projectile_reference = projectile
	
	source.call_deferred("add_child", projectile)
	
func reset_collision():
	if projectile_reference:
		projectile_reference.find_child("CollisionShape2D").disabled = true
		projectile_reference.find_child("CollisionShape2D").disabled = false
		

func pulsate(tree):
	if is_instance_valid(projectile_reference):
		## function to pulsae the projectile
		var tween = tree.create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(projectile_reference, "scale", Vector2(area + 0.1,area + 0.1), 0.25)
		tween.chain().tween_property(projectile_reference, "scale", Vector2(area,area), 0.25)
		tween.bind_node(projectile_reference)

		
func upgrade_item():
	if max_level_reached():
		slot.item = evolution
		return
	
	if not is_upgradable():
		return
		
	var upgrade = upgrades[level - 1]
	
	area += upgrade.area
	cooldown += upgrade.cooldown
	damage += upgrade.damage
	
	level += 1
	
