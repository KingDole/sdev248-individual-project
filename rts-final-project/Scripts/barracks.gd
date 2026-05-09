extends StaticBody2D

class_name Building

@export var spawnPoint : Node2D 

var units : Dictionary = {
	"Knight" : preload("res://Scenes/unit_player.tscn"),
	"Cleric" : preload("res://Scenes/unit_cleric.tscn"),
}

func build_unit (unit : String) -> void:
	var instance = units[unit].instantiate()
	get_parent().add_child(instance)
	instance.position = spawnPoint.global_position
	
