extends Node3D

@onready var enemy_scene = preload("res://enemies/Enemy.tscn")

func _on_timer_timeout() -> void:
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.type = randi() % game_state.types_of_masks.size()
	enemy_instance.global_position = global_position
	get_parent().add_child(enemy_instance)
