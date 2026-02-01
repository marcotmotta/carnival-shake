extends Area3D

@export var speed := 20.0
@export var damage := 40

var direction := Vector3.FORWARD

@onready var hit_particle_scene = preload("res://projectiles/HitParticle.tscn")

@export var type: game_state.types_of_masks

var hitted_enemies = []

var rotation_axis: Vector3
@export var rotation_speed := 5.0

func _ready() -> void:
	# Pick random axis once
	rotation_axis = Vector3(randf() - 0.5, randf() - 0.5, randf() - 0.5).normalized()

func _process(delta: float) -> void:
	$Model.rotate(rotation_axis, rotation_speed * delta)

func _physics_process(delta):
	global_position += direction * speed * delta

func _on_body_entered(body):
	if not body.is_in_group('player'):
		if body.is_in_group('enemy') and not hitted_enemies.has(body):
			if body.type != 7: # is not boss
				if body.type == type:
					hitted_enemies.append(body)
					body.take_damage(damage)
					body.take_knockback(global_position, 30.0)

					var hit_particle_instance = hit_particle_scene.instantiate()
					hit_particle_instance.global_position = global_position
					hit_particle_instance.type = type
					get_parent().add_child(hit_particle_instance)
			else: # is boss
				hitted_enemies.append(body)
				body.take_damage(damage, type)
				body.take_knockback(global_position, 10.0)

				var hit_particle_instance = hit_particle_scene.instantiate()
				hit_particle_instance.global_position = global_position
				hit_particle_instance.type = type
				get_parent().add_child(hit_particle_instance)

func _on_timer_timeout() -> void:
	queue_free()
