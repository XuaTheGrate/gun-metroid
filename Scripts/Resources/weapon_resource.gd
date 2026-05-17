class_name WeaponResource extends Resource

@export var name: String
@export_file("*.tscn") var projectile: String = "res://Scenes/bullet.tscn"

@export_category("Meta")
@export var magazine_size: int
@export var bullet_speed: float
@export var damage: int
@export var reload_time: float
@export var fire_rate: float
@export var projectile_count: int = 1
@export var self_knockback: float

@export_category("Tags")
@export var area_of_effect: bool
@export var damage_over_time: bool
@export var knockback: bool
@export var self_damage: bool
@export var projectile_spread: bool
