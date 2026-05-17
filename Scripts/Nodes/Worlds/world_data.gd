class_name WorldData extends Node2D

@export var world_name: String

@export_category("Camera")
@export var camera_limited := false
@export var camera_limit_left: int = -10000000
@export var camera_limit_top: int = -10000000
@export var camera_limit_right: int = 10000000
@export var camera_limit_bottom: int = 10000000


var spawnpoints:
	get: return get_tree().get_nodes_in_group(&"Spawnpoints")
