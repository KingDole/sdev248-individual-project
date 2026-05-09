extends Node

var level: int = 0

func _ready():
	var file_path = "res://save.txt"
	var file := FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		return
	var content := file.get_as_text() 
	file.close()
	if content == "":
		return
	var json = JSON.new()
	var error = json.parse(content)
	if error != OK:
		return
	var data_loaded = json.data
	level = data_loaded["level"]

func CompleteLevel(l: int) -> void: 
	if l < level: return 
	level = l + 1 
	if level > 2:
		level = 1
	var levelJSON = {"level": level} 
	var json_string = JSON.stringify(levelJSON, "\t", true) 
	var file_path = "res://save.txt" 
	var file := FileAccess.open(file_path, FileAccess.WRITE) 
	if file == null: 
		return 
	file.store_string(json_string)
	file.close()
