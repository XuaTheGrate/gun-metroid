class_name WeaponController extends Node2D

@export var player: PlayerController

func get_weapon() -> WeaponBase:
	return get_tree().get_first_node_in_group(&"Weapons")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Fire"):
		get_weapon().fire()
