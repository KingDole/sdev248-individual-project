extends AnimatedSprite2D

@onready var unit : Unit = get_parent()
var unit_pos_last_frame : Vector2

func _ready ():
	unit.OnTakeDamage.connect(_damage_flash)

func _process (delta):
	var dir = unit.global_position.x - unit_pos_last_frame.x
	
	if dir > 0:
		flip_h = false
	elif dir < 0:
		flip_h = true
	
	unit_pos_last_frame = unit.global_position

func _damage_flash (health : int):
	modulate = Color.RED
	await get_tree().create_timer(0.05).timeout
	modulate = Color.WHITE
