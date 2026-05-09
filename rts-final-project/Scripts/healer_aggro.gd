extends Area2D

@onready var unit : Unit = get_parent()

func _ready() -> void:
	unit.ready.connect(_connect_signal)
	
func _connect_signal():
	unit.agent.navigation_finished.connect(_finished_moving)

func _combat_range(area: Area2D) -> void:
	if not unit.agent.is_navigation_finished() or unit.attack_target != null:
		return
		
	var raw_list = get_tree().get_nodes_in_group("Healable")
	
	if raw_list.has(area) and unit.attack_target == null:
		unit.set_attack_target(unit, area)
		if not (area as Unit).OnDie.is_connected(_target_swapped):
			(area as Unit).OnDie.connect(_target_swapped)
		if not (area as Unit).OnHealed.is_connected(_target_swapped):
			(area as Unit).OnHealed.connect(_target_swapped)
		
func _finished_moving():
	if unit.attack_target != null:
		return
	_target_swapped(null)
		
func _target_swapped(target : Unit):
	var targets = get_overlapping_areas()
	var raw_list = get_tree().get_nodes_in_group("Healable")
	var new_target : Unit = null
	var injured : Array[Unit] = []
	
	for node in raw_list:
		if (node as Unit).cur_hp < (node as Unit).max_hp:
			injured.append(node)
	
	for t in targets:
		if t == unit.attack_target and (t as Unit).cur_hp <= (t as Unit).max_hp:
			return
		if not injured.has(t):
			continue
			
		var dist = unit.global_position.distance_to(t.global_position)
		if new_target == null or dist < unit.global_position.distance_to(new_target.global_position):
			new_target = t as Unit

	if new_target != null:
		unit.set_attack_target(unit, new_target)
		if not new_target.OnDie.is_connected(_target_swapped):
			new_target.OnDie.connect(_target_swapped)
		if not new_target.OnHealed.is_connected(_target_swapped):
			new_target.OnHealed.connect(_target_swapped)

func _out_of_range(area: Area2D) -> void:
	if area is Unit:
		if area.OnDie.is_connected(_target_swapped):
			area.OnDie.disconnect(_target_swapped)
		if area.OnHealed.is_connected(_target_swapped):
			area.OnHealed.disconnect(_target_swapped)
