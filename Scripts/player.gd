extends CharacterBody2D

var speed : float = 150
var health : float = 100:
	##make health a setter variable to update progress bar
	set(value):
		health = value
		%Health.value = value

var nearest_enemy : CharacterBody2D
var nearest_enemy_distance : float = INF
var knockback = 100

func _physics_process(delta: float) -> void:
	if is_instance_valid(nearest_enemy): 
		nearest_enemy_distance = nearest_enemy.separation
		print(nearest_enemy.name)
	else: 
		nearest_enemy_distance = INF

	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	move_and_collide(velocity * delta)

##function to reduce health	
func take_damage(amount):
	health -= amount
	print(amount)

func _on_self_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)


func _on_timer_timeout() -> void:
	## disable and enable with each timeout 
	%Collision.set_deferred("disabled", true)
	%Collision.set_deferred("disabled", false)
