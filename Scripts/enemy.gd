extends CharacterBody2D
 
var player_reference : CharacterBody2D
var direction : Vector2
var speed : float = 75
var damage : float = 0
var knockback : Vector2
var separation : float


var elite : bool = false:
	set(value):
		elite = value
		if value:
			$Sprite2D.material = load("res://Shaders/EnemyOutline.tres")
			scale = Vector2(1.5,1.5)
 
var type : Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage
 
func _physics_process(delta):
	check_separation(delta)
	knockback_update(delta)

func check_separation(_delta):
	separation = (player_reference.position - position).length()
	if separation >= 500 and not elite: 
		queue_free() 
	if separation < player_reference.nearest_enemy_distance: 
		player_reference.nearest_enemy = self

func knockback_update(delta): 
	velocity = (player_reference.position - position).normalized() * speed
	knockback = knockback.move_toward(Vector2.ZERO, 1)
	velocity += knockback
	
	var collider = move_and_collide(velocity * delta)
	if collider:
		collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * 50
