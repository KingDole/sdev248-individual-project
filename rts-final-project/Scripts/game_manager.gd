extends Node2D
class_name Game

@export var game_level = 1

var units = {
	Unit.Team.PLAYER: 0, 
	Unit.Team.AI: 0
}

var resources : int = 500

func change_resources (cost : int):
	resources -= cost
	%Money.text = str(resources)

func _ready ():
	for unit in get_tree().get_nodes_in_group("Unit"):
		if unit is not Unit:
			continue
		
		units[unit.team] += 1
		unit.OnDie.connect(_on_unit_die)

func _on_unit_die (unit : Unit):
	if unit.is_in_group("UnitAI"):
		resources += unit.reward
		%Money.text = str(resources)
	unit.queue_free()
	_check_win_condition()
		
func _check_win_condition ():
	units [Unit.Team.PLAYER] = 0
	units [Unit.Team.AI] = 0
	for unit in get_tree().get_nodes_in_group("Unit"):
		if unit is not Unit:
			continue
		
		units[unit.team] += 1

	if units [Unit.Team.PLAYER] == 1:
		get_tree().call_deferred("change_scene_to_file","res://Scenes/level_menu.tscn")
	elif units [Unit.Team.AI] == 1:
		SaveLoad.CompleteLevel(game_level)
		get_tree().call_deferred("change_scene_to_file","res://Scenes/level_menu.tscn")
