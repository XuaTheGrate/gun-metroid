class_name Game extends Control

@export var root_container: SceneContainer
@onready var transition: TransitionManager = %TransitionManager

static var instance: Game

var main_menu: MainMenu:
	get:
		if root_container.current_scene != null and root_container.current_scene is MainMenu:
			return root_container.current_scene
		return null

func _ready() -> void:
	if Game.instance == null:
		Game.instance = self
	else:
		push_error("Game instance already set")
		return
	await launch_main_menu()

func launch_main_menu() -> void:
	root_container.replace_scene(MainMenu.create())
	await %TransitionManager.fade_in(0.8)

func start_new_game() -> void:
	await transition.fade_out(0.8)
	root_container.replace_scene(Platformer.create())
	print("new game")
	await transition.fade_in(0.8)
	print("start")
	Platformer.instance.new_game()
