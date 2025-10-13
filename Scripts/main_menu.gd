extends Control

func _ready():
	menu()

func _on_upgrades_pressed() -> void:
	skill_tree()

func _on_atlas_pressed() -> void:
	Archive()

func menu():
	$Menu.show()
	$SkillTree.hide()
	$Archive.hide()
	$Gold.hide()
	$Back.hide()
	tween_pop($Menu)

func skill_tree():
	$SkillTree.show()
	$Gold.show()
	$Menu.hide()
	$Back.show()
	tween_pop($SkillTree)
	
func Archive():
	$Archive.show()
	$Menu.hide()
	$Gold.hide()
	$Back.show()
	tween_pop($Archive)

func _on_back_pressed() -> void:
	menu()

func tween_pop(panel):
	## add sound later!
	## SoundManager.play_sfx(load())
	panel.scale = Vector2(0.85, 0.85)
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(panel, "scale", Vector2(1, 1), 0.5)
