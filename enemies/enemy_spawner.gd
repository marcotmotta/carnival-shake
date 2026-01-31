extends Node3D

@export var wait_time = 4.0

@onready var enemy_scene = preload("res://enemies/Enemy.tscn")
@onready var timer = $Timer
@onready var spawn_points = $SpawnPoints

func _ready():
	timer.wait_time = wait_time

func get_random_spawn_position():
	return spawn_points.get_children().pick_random().global_position

func _on_timer_timeout():
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.type = randi() % game_state.types_of_masks.size()
	get_parent().add_child(enemy_instance)
	enemy_instance.global_position = get_random_spawn_position()
