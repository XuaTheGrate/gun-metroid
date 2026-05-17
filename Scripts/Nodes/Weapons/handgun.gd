extends WeaponBase

func fire() -> void:
	if not should_fire(): return
	_cooldown = fire_rate
	raycast.target_position = get_local_mouse_position().normalized() * raycast_length
