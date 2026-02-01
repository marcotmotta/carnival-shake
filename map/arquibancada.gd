extends Node3D

func _ready() -> void:
	$AnimationPlayer.play("new_animation", -1, randf_range(0.8, 1.2))
