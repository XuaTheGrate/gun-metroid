class_name SceneContainer extends Control

var _current_scene: Control

var current_scene: Control:
	get:
		if _current_scene == null: return null
		if not is_instance_valid(_current_scene): return null
		if _current_scene.is_queued_for_deletion(): return null
		return _current_scene
	set(value):
		_current_scene = value

func replace_scene(node: Control):
	for child in get_children():
		remove_child(child)
		child.queue_free()
	current_scene = node
	if node.get_parent() == null:
		add_child(node)
	else:
		node.reparent(self)
