class_name BackgroundParallax extends Control

@export var length := 1152
@export var speed := 1.0

func _process(delta: float) -> void:
	position.x -= delta * speed
	if position.x <= 0:
		position.x += length
