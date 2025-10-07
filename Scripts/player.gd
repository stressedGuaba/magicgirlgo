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

var XP : int = 0:
	set(value):
		XP = value
		%XP.value = value
var total_XP : int = 0
var level : int = 1:
	set(value):
		level = value
		%Level.text = "Lv" + str(value)
		%Options.show_option()
		
		if level >= 3:
			%XP.max_value = 20
		elif level >= 7: 
			%XP.max_value = 40

func _physics_process(delta: float) -> void:
	if is_instance_valid(nearest_enemy): 
		nearest_enemy_distance = nearest_enemy.separation
		print(nearest_enemy.name)
	else: 
		nearest_enemy_distance = INF

	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	move_and_collide(velocity * delta)
	check_XP()

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

func gain_XP(amount):
	XP += amount
	total_XP += amount

func check_XP():
	if XP > %XP.max_value: 
		XP -= %XP.max_value
		level += 1
		

func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"): 
		area.follow(self)
		
