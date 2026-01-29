extends Area3D

@export var type : game_state.types_of_masks

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		collect(body)

func collect(player):
	player.add_mask(type)

	queue_free()
