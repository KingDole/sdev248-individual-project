extends Node2D

@export var build_panel : Panel
var selected_building : Building

@onready var game : Game = get_parent() as Game

func _input (event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_try_select_building()

func _try_select_building ():
	if build_panel.visible and get_viewport().get_mouse_position().y > build_panel.position.y:
		return

	var building = _get_selected_building()
	
	if building == null:
		_unselect_building()
	else:
		_select_building(building)
	
func _select_building (building : Building):
	_unselect_building()
	selected_building = building
	build_panel.visible = true
	(build_panel.get_child(0) as TextureButton).disabled = game.resources < 200
	(build_panel.get_child(1) as TextureButton).disabled = game.resources < 300
	#unit.get_node("PlayerUnit").toggle_selection_visual(true)
	
func _unselect_building ():
	#if selected_building != null:
		#selected_building.get_node("PlayerUnit").toggle_selection_visual(false)
	
	selected_building = null
	build_panel.visible = false
		
func _get_selected_building () -> Building:
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	var intersection = space.intersect_point(query, 1)
	
	if intersection.is_empty():
		return null
	
	if intersection[0].collider is not Building:
		return null

	return intersection[0].collider

func _build_unit(unit : String) -> void:
	selected_building.build_unit(unit)
	
	if unit == "Knight":
		game.change_resources(200)
	if unit == "Cleric":
		game.change_resources(300)
	
	(build_panel.get_child(0) as TextureButton).disabled = game.resources < 200
	(build_panel.get_child(1) as TextureButton).disabled = game.resources < 300
