class_name Platformer extends Control

static var _scene := preload("res://Scenes/platformer.tscn")
static var instance: Platformer

var _player := preload("res://Scenes/simple_player.tscn")

var _cached_level: WorldData = null
var _preferred_spawn := -1

static func create() -> Platformer:
	if instance != null: return instance
	instance = _scene.instantiate()
	return instance

func new_game() -> void:
	print("loading level")
	var level := preload("res://Scenes/debug.tscn").instantiate()
	set_level(level)
	if not level.is_node_ready():
		await level.ready
	print("level ready")
	var player := set_player()
	if not player.is_node_ready():
		await player.ready
	print("player ready")
	player.active = true

func get_player() -> PlayerController:
	return get_tree().get_first_node_in_group(&"PlayerController")

func set_player() -> PlayerController:
	var player := get_player()
	if player == null:
		print("placing new player")
		player = _player.instantiate()
		add_child(player)
	if _cached_level != null:
		var spawn: Vector2 = _cached_level.spawnpoints[_preferred_spawn].global_position
		player.move_to_spawn(spawn)
		
		if _cached_level.camera_limited:
			player.set_camera_limits(
				_cached_level.camera_limit_top,
				_cached_level.camera_limit_bottom,
				_cached_level.camera_limit_left,
				_cached_level.camera_limit_right
			)
		else:
			player.reset_camera_limits()
		
		_preferred_spawn = -1
		_cached_level = null
	print("player ", player)
	return player

func set_level(level: WorldData, spawnpoint: int = 0) -> void:
	print("setting level ", level)
	add_child(level)
	_cached_level = level
	_preferred_spawn = spawnpoint
