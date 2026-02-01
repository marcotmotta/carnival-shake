extends Node3D

@export var wait_time = 6.0

@onready var enemy_scene = preload("res://enemies/Enemy.tscn")
@onready var timer = $Timer
@onready var spawn_points = $SpawnPoints

var total_enemies = 10

func _process(delta):
	if total_enemies == 0 and len(get_tree().get_nodes_in_group('enemy')) <= 0:
		total_enemies = -1 # Set this to stop function from running multiple times.
		get_parent().change_wave()

func _ready():
	timer.wait_time = wait_time

func start_boss():
	total_enemies = 1
	spawn_enemy(true)

func start(current_wave):
	total_enemies = (current_wave + 1) * 5
	spawn_enemy()
	timer.start()

func spawn_enemy(is_boss = false):
	var enemy_instance = enemy_scene.instantiate()

	if is_boss:
		enemy_instance.type = 7
	else:
		enemy_instance.type = randi() % (game_state.types_of_masks.size() - 1)

	get_parent().add_child(enemy_instance)

	enemy_instance.global_position = get_random_spawn_position()

	total_enemies -= 1
	if total_enemies == 0:
		timer.stop()

func get_random_spawn_position():
	return spawn_points.get_children().pick_random().global_position

func _on_timer_timeout():
	spawn_enemy()
