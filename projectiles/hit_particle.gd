extends CPUParticles3D

var type

func _ready() -> void:
	mesh.material.albedo_color = game_state.get_mask_color(type)
	emitting = true

func _on_finished() -> void:
	queue_free()
