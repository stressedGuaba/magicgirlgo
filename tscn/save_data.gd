extends Node2D

var gold = 1000

const PATH = "user://player_data.cfg"
@onready var config = ConfigFile.new()

func _ready():
	load_data()

func save_data():
	config.save(PATH)
	
func set_data():
	config.set_value("Player", "gold", gold)

func set_and_save():
	set_data()
	save_data()
	
func load_data():
	if config.load(PATH) != OK:
		set_and_save()
		
		gold = config.get_value("Player", "gold", 1000)
		
