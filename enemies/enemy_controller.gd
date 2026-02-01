extends CharacterBody3D

@export var speed := 5.0
@export var knockback_velocity := Vector3.ZERO
@export var knockback_force := 40.0
@export var knockback_friction := 5.0

var player: Node3D
var type: game_state.types_of_masks

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var damage = 20
@onready var max_health = 100
@onready var health = 100
@onready var blue_health = 12
@onready var red_health = 12
@onready var yellow_health = 12

@onready var heal_scene = preload("res://heal/Heal.tscn")

func _ready():
	# Get player node.
	player = get_tree().get_first_node_in_group("player")

	# Select model based on type
	if type <= 6: # not boss
		$Model.get_node(str(type)).visible = true # am i genius?
	else:
		damage = 25
		$Model/boss.visible = true

	# Wait for navigation to be ready.
	await get_tree().physics_frame

func _physics_process(delta):
	if player:
		nav_agent.target_position = player.global_position

	if nav_agent.is_navigation_finished():
		return

	var next_point = nav_agent.get_next_path_position()
	var direction = (next_point - global_position).normalized()
	
	print(nav_agent.target_position)
	print(next_point)
	print(direction)

	velocity = direction * speed + knockback_velocity

	move_and_slide()

	# Decay knockback over time.
	knockback_velocity = knockback_velocity.lerp(Vector3.ZERO, knockback_friction * delta)

	# Face movement direction.
	var target_position = global_position + Vector3(direction.x, 0, direction.z)
#
	if global_position.distance_to(target_position) > 0.01:
		look_at(target_position)

func take_knockback(from_position, force = knockback_force):
	var direction = (global_position - from_position).normalized()
	direction.y = 0
	direction = direction.normalized()
	
	knockback_velocity = direction * force

func take_damage(amount, hit_type = null):
	if hit_type != null: # Is not boss.
		health = max(0, health - amount)

		if health <= 0:
			if (randi() % 100) <= 5: # 5% chance to spawn a heal on death
				var heal_instance = heal_scene.instantiate()
				heal_instance.global_position = global_position
				get_parent().add_child(heal_instance)

			queue_free()

	else: # Is boss.
		# Blue hit.
		if [game_state.types_of_masks.tartaruga, game_state.types_of_masks.peixe].has(hit_type):
			blue_health = max(0, blue_health - 1)

			if blue_health <= 0:
				$"Model/boss/Carla Perez 1".get_node('GARCA_001/Skeleton3D/Cube_002').mesh.surface_get_material(11).albedo_color = '#000000'
				$"Model/boss/Carla Perez 1".get_node('GARCA_001/Skeleton3D/Cube_002').mesh.surface_get_material(11).blend_mode = 1
				$"Model/boss/Carla Perez 1".get_node('GARCA_001/Skeleton3D/Cube_002').mesh.surface_get_material(11).emission_energy_multiplier = 0

		# Red hit.
		elif [game_state.types_of_masks.arara, game_state.types_of_masks.garca].has(hit_type):
			red_health = max(0, red_health - 1)

			if red_health <= 0:
				$"Model/boss/Carla Perez 1".get_node('GARCA_001/Skeleton3D/Cube_002').mesh.surface_get_material(10).albedo_color = '#000000'
				$"Model/boss/Carla Perez 1".get_node('GARCA_001/Skeleton3D/Cube_002').mesh.surface_get_material(10).blend_mode = 1
				$"Model/boss/Carla Perez 1".get_node('GARCA_001/Skeleton3D/Cube_002').mesh.surface_get_material(11).emission_energy_multiplier = 0

		# Yellow hit.
		elif [game_state.types_of_masks.macaco, game_state.types_of_masks.onca].has(hit_type):
			yellow_health = max(0, yellow_health - 1)

			if yellow_health <= 0:
				$"Model/boss/Carla Perez 1".get_node('GARCA_001/Skeleton3D/Cube_002').mesh.surface_get_material(12).albedo_color = '#000000'
				$"Model/boss/Carla Perez 1".get_node('GARCA_001/Skeleton3D/Cube_002').mesh.surface_get_material(12).blend_mode = 1
				$"Model/boss/Carla Perez 1".get_node('GARCA_001/Skeleton3D/Cube_002').mesh.surface_get_material(11).emission_energy_multiplier = 0

		if (blue_health + red_health + yellow_health) == 0:
			queue_free()

func _on_hit_area_body_entered(body):
	if body.is_in_group('player'):
		body.take_damage(damage)

		take_knockback(player.global_position, knockback_force)
