class_name TransitionManager extends ColorRect

var _tween: Tween = null

func fade_in(time: float):
	if _tween != null:
		_tween.kill()
	modulate.a = 1.0
	_tween = create_tween().parallel()
	_tween.tween_property(self, "modulate:a", 0.0, time).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	await _tween.finished

func fade_out(time: float):
	if _tween != null:
		_tween.kill()
	modulate.a = 0.0
	_tween = create_tween().parallel()
	_tween.tween_property(self, "modulate:a", 1.0, time).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	await _tween.finished
