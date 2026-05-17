class_name MainMenu extends Control

static var _scene := preload("res://Scenes/Menus/main_menu.tscn")

var _button_pressed := false

static func create() -> MainMenu:
	var menu: MainMenu = _scene.instantiate()
	return menu

func _on_new_game_button_pressed() -> void:
	if _button_pressed:
		return
	_button_pressed = true
	Game.instance.start_new_game()
