extends Area2D

var direction : Vector2
var speed : float = 175

@export var type : Pickups
@export var player_reference : CharacterBody2D:
	set(value):
		player_reference = value
		type.player_reference = value

## flag variable to follow player		
var can_follow : bool = false

func _ready():
	$Sprite2D.texture = type.icon	
	
func _physics_process(delta):
	if player_reference and can_follow:
		direction = (player_reference.position - position).normalized()
		position += direction * speed * delta
		
func follow(_target : CharacterBody2D, gem_flag = false): 
	if type is Chest:
		return
	if gem_flag == true:
		if type is Gem:
			can_follow = true
		return
	can_follow = true
	

func _on_body_entered(body: Node2D) -> void:
	type.activate()
	queue_free()
	
