extends Area3D

@export var type = null

var masks = [0, 1, 2, 3, 4, 5, 6]

func _ready():
	body_entered.connect(_on_body_entered)

	var mesh_instance = $Visual/fbx_24h/Cube
	mesh_instance.mesh = mesh_instance.mesh.duplicate()

func select_mask(mask_type):
	if type != null: # remove current mask
		$Visual/Masks.get_node(str(type)).visible = false

	type = mask_type
	var color = game_state.get_mask_color(mask_type)
	var mesh = $Visual/fbx_24h/Cube.mesh
	
	var mat1 = mesh.surface_get_material(1).duplicate()
	var mat6 = mesh.surface_get_material(6).duplicate()
	mat1.albedo_color = color
	mat1.emission = color
	mat6.albedo_color = color
	mat6.emission = color
	mesh.surface_set_material(1, mat1)
	mesh.surface_set_material(6, mat6)
	$Visual/Masks.get_node(str(type)).visible = true

func become_inactive():
	if type != null: # remove current mask
		$Visual/Masks.get_node(str(type)).visible = false

	type = null
	var color = Color('#000000')
	var mesh = $Visual/fbx_24h/Cube.mesh
	
	var mat1 = mesh.surface_get_material(1).duplicate()
	var mat6 = mesh.surface_get_material(6).duplicate()
	mat1.albedo_color = color
	mat1.emission = color
	mat6.albedo_color = color
	mat6.emission = color
	mesh.surface_set_material(1, mat1)
	mesh.surface_set_material(6, mat6)

func _on_body_entered(body):
	if body.is_in_group("player") and type != null:
		collect(body)

func collect(player):
	player.add_mask(type)
	_shuffle_masks()

func _shuffle_masks():
	var totens = get_parent().get_children()
	masks.shuffle()
	
	var assigned_masks = [] # array of masks without the mask that was just picked
	for mask in masks:
		if mask != type:
			assigned_masks.append(mask)

	var aux = 0

	for totem in totens:
		if totem != self:
			totem.select_mask(assigned_masks[aux])
			aux += 1
		else:
			totem.become_inactive()
