extends Node3D

@export var starter_countdown_time = 3

@onready var curr_game_stage = game_state.stages.COUNTING_DOWN_TO_START
@onready var timer: Timer = Timer.new()
@onready var countdown_label: Label = $CanvasLayer/CountdownLabel
@onready var enemy_spawner = $EnemySpawner

func _ready():
	add_child(timer)
	
	timer.wait_time = starter_countdown_time
	timer.one_shot = true

	start_countdown()

func start_countdown():
	countdown_label.visible = true

	for i in range(starter_countdown_time, 0, -1):
		countdown_label.text = str(i)
		await get_tree().create_timer(1.0).timeout
	countdown_label.text = "GO!"
	await get_tree().create_timer(0.5).timeout
	countdown_label.visible = false

	on_countdown_finished()

func on_countdown_finished():
	curr_game_stage = game_state.stages.PLAYING
	enemy_spawner.start()
