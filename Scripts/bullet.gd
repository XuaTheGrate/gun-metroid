class_name BulletProjectile extends CharacterBody2D

func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)
	if collision != null:
		queue_free()

func _on_screen_exited() -> void:
	queue_free()
