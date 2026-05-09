extends Node2D

@export var spawnTimer : Timer
@export var spawnPoint : Node2D 

func build_unit () -> void:
	var instance : Unit = preload("res://Scenes/unit_ai.tscn").instantiate() as Unit
	var game = get_parent().get_parent() as Game
	game.add_child(instance)
	instance.OnDie.connect(game._on_unit_die)
	instance.position = spawnPoint.global_position
