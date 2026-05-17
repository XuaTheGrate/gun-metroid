class_name PlayerController extends CharacterBody2D

@export_group("Horizontal")
@export var move_speed := 200.0
@export var acceleration := 1200.0
@export var deceleration := 1600.0
@export var air_acceleration = 600.0
@export var air_deceleration = 400.0

@export_group("Vertical")
@export var jump_height := 96.0
@export var jump_time_to_peak := 0.4
@export var jump_time_to_drop := 0.3
@export var coyote_time := 0.12
@export var jump_buffer_time := 0.15

@export_group("Gravity")
@export var fall_multiplier := 1.5
@export var max_fall_speed := 600.0

@export_group("Misc")
@export var camera: Camera2D

var _gravity: float
var _fall_gravity: float
var _jump_velocity: float

var _was_on_floor: bool
var _coyote_timer: float
var _jump_buffer_timer: float

var active := false

func _ready() -> void:
	recalculate_jump_physics()

func _physics_process(delta: float) -> void:
	if not active: return
	
	update_timers(delta)
	apply_gravity(delta)
	handle_jump_input()
	handle_horizontal_movement(delta)
	
	move_and_slide()
	
	post_move_checks()

func move_to_spawn(pos: Vector2) -> void:
	global_position = pos

func set_camera_limits(top: int, bottom: int, left: int, right: int) -> void:
	camera.limit_enabled = true
	camera.limit_top = top
	camera.limit_bottom = bottom
	camera.limit_left = left
	camera.limit_right = right

func reset_camera_limits() -> void:
	camera.limit_enabled = false

func recalculate_jump_physics() -> void:
	_jump_velocity = (2.0 * jump_height) / jump_time_to_peak
	_gravity = _jump_velocity / jump_time_to_peak
	_fall_gravity = _gravity * fall_multiplier * (jump_time_to_peak / jump_time_to_drop)

func update_timers(delta: float) -> void:
	if is_on_floor():
		_coyote_timer = coyote_time
		_was_on_floor = true
	else:
		if _was_on_floor:
			_was_on_floor = false
		_coyote_timer = maxf(_coyote_timer - delta, 0.0)
	
	_jump_buffer_timer = maxf(_jump_buffer_timer - delta, 0.0)

func apply_gravity(delta: float) -> void:
	if is_on_floor(): return
	var g := _fall_gravity if velocity.y >= 0.0 else _gravity
	var vy := velocity.y + g * delta
	velocity = Vector2(velocity.x, minf(vy, max_fall_speed))

func handle_jump_input() -> void:
	if Input.is_action_just_pressed(&"Jump"):
		_jump_buffer_timer = jump_buffer_time
	
	var can_jump := _coyote_timer > 0.0 || is_on_floor()
	var wants_jump := _jump_buffer_timer > 0.0
	if wants_jump and can_jump:
		execute_jump()
	
	if Input.is_action_just_released(&"Jump") and velocity.y < 0.0:
		velocity = Vector2(velocity.x, velocity.y * 0.5)

func execute_jump() -> void:
	velocity = Vector2(velocity.x, -_jump_velocity)
	_jump_buffer_timer = 0.0
	_coyote_timer = 0.0

func handle_horizontal_movement(delta: float) -> void:
	var input := Input.get_axis("Left", "Right")
	var accel: float
	
	if is_on_floor():
		accel = acceleration if input != 0.0 else deceleration
	else:
		accel = air_acceleration if input != 0.0 else air_deceleration
	
	var target_vx := input * move_speed
	var vx = move_toward(velocity.x, target_vx, accel * delta)
	velocity = Vector2(vx, velocity.y)

func post_move_checks() -> void:
	if is_on_ceiling() and velocity.y < 0.0:
		velocity = Vector2(velocity.x, 0.0)
