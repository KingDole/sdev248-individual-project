extends Panel

@onready var header_text : Label = $Label

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
