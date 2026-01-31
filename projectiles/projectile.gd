extends Area3D

@export var speed := 20.0
@export var damage := 40

var direction := Vector3.FORWARD

@export var type: game_state.types_of_masks

func _physics_process(delta):
	global_position += direction * speed * delta

func _on_body_entered(body):
	if not body.is_in_group('player'):
		if body.is_in_group('enemy'):
			if body.type == type:
				body.take_damage(damage)
				body.take_knockback(global_position, 30.0)

			queue_free()

func _on_timer_timeout() -> void:
	queue_free()
