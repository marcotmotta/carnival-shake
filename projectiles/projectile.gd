extends Area3D

@export var speed := 30.0
@export var damage := 40

var direction := Vector3.FORWARD

@onready var hit_particle_scene = preload("res://projectiles/HitParticle.tscn")

@export var type: game_state.types_of_masks

var hitted_enemies = []

var rotation_axis: Vector3
@export var rotation_speed := 5.0

@onready var audio_player = preload("res://audio/AudioPlayer.tscn")
@onready var audio_projectiles = [
	preload("res://audio/Tiro - Beija Flor 1.mp3"),
	preload("res://audio/Tiro - Tartaruga 1.mp3"),
	preload("res://audio/Tiro - Garca 1.mp3"),
	preload("res://audio/Tiro - Arara 1.mp3"),
	preload("res://audio/Tiro - Mico 1.mp3"),
	preload("res://audio/Tiro - Onca 1.mp3"),
	preload("res://audio/Tiro - Peixe 1.mp3")
]

func _ready():
	# Pick random axis once.
	rotation_axis = Vector3(randf() - 0.5, randf() - 0.5, randf() - 0.5).normalized()
	
	var audio = audio_player.instantiate()
	audio.stream = audio_projectiles[type]
	audio.volume_db = -28
	get_parent().add_child(audio)

func _process(delta):
	$Model.rotate(rotation_axis, rotation_speed * delta)

func _physics_process(delta):
	global_position += direction * speed * delta

func _on_body_entered(body):
	if not body.is_in_group('player'):
		if body.is_in_group('enemy') and not hitted_enemies.has(body):
			if body.type != 7: # Is not boss.
				if body.type == type:
					hitted_enemies.append(body)
					body.take_damage(damage)
					body.take_knockback(global_position, 30.0)

					var hit_particle_instance = hit_particle_scene.instantiate()
					hit_particle_instance.type = type
					get_parent().add_child(hit_particle_instance)
					hit_particle_instance.global_position = global_position

			else: # Is boss.
				hitted_enemies.append(body)
				body.take_damage(damage, type)
				body.take_knockback(global_position, 15.0)

				var hit_particle_instance = hit_particle_scene.instantiate()
				hit_particle_instance.type = type
				get_parent().add_child(hit_particle_instance)
				hit_particle_instance.global_position = global_position

func _on_timer_timeout():
	queue_free()
