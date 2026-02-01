extends CPUParticles3D

var type

func _ready():
	mesh.material.albedo_color = game_state.get_mask_color(type)
	emitting = true

func _on_finished():
	queue_free()
