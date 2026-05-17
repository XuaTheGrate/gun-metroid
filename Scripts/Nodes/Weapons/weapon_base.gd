class_name WeaponBase extends Node2D

@export var weapon_name: String
@export var fire_rate: float
@export_range(1, 2_147_483_647) var magazine_size: int
@export var reload_speed: float

@export var raycast_length = 700.0

@onready var raycast: RayCast2D = $RayCast2D

var _cooldown := 0.0

func _ready() -> void:
	add_to_group(&"Weapons")

func _physics_process(delta: float) -> void:
	if not is_node_ready(): return
	_cooldown = maxf(_cooldown - delta, 0.0)

func should_fire() -> bool:
	return _cooldown == 0.0

func fire() -> void:
	pass
