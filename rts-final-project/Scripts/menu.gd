extends Control



func _on_play_button_pressed() -> void:
	if SaveLoad.level == 1:
		get_tree().change_scene_to_file("res://Scenes/game.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/level_two.tscn")
		
func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _next_level() -> void:
	if SaveLoad.level == 2:
		get_tree().change_scene_to_file("res://Scenes/level_two.tscn")
