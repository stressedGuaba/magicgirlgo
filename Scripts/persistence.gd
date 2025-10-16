extends Node2D

@onready var bonus_stats : Stats = Stats.new()

var character = null

func gain_bonus_stats(player):
	player.max_health += bonus_stats.max_health
	player.recovery += bonus_stats.recovery
	player.armor += bonus_stats.armor
	player.movement_speed += bonus_stats.movement_speed
	player.might += bonus_stats.might
	player.area += bonus_stats.area
	player.magnet += bonus_stats.magnet
	player.growth += bonus_stats.growth
	player.luck += bonus_stats.luck
	
	
	
