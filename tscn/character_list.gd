extends GridContainer
 
@export var character_slot : PackedScene

@onready var starting_character = %StartingCharacter
 
@export var characters : Array[Character]
 
func _ready():
	load_characters()
 
func load_characters():
	for character in characters:
		var slot = character_slot.instantiate()
		slot.icon = character.icon
		slot.pressed.connect(_on_pressed.bind(character))
		add_child(slot)
 
func _on_pressed(character : Character):
	Persistence.character = character
	starting_character.texture = character.starting_character.icon
