extends Area3D

@export var type : game_state.types_of_masks

func _ready():
	body_entered.connect(_on_body_entered)

	$Visual/fbx_24h/Cube.mesh.surface_get_material(1).albedo_color = '#ff0000'
	$Visual/fbx_24h/Cube.mesh.surface_get_material(1).emission = '#ff0000'
	$Visual/fbx_24h/Cube.mesh.surface_get_material(6).albedo_color = '#ff0000'
	$Visual/fbx_24h/Cube.mesh.surface_get_material(6).emission = '#ff0000'

func _on_body_entered(body):
	if body.is_in_group("player"):
		collect(body)

func collect(player):
	player.add_mask(type)

	queue_free()
