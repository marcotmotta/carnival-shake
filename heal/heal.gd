extends Area3D

@onready var audio_player_scene = preload("res://audio/AudioPlayer.tscn")
@onready var heal_sound = preload("res://audio/Latinha Heal.mp3")

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		body.heal(30)

		var audio = audio_player_scene.instantiate()
		audio.stream = heal_sound
		get_parent().add_child(audio)

		queue_free()
