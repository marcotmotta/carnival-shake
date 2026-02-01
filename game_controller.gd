extends Node3D

@export var starter_countdown_time = 10

@onready var curr_game_stage = game_state.stages.COUNTING_DOWN_TO_START
@onready var timer: Timer = Timer.new()
@onready var countdown_label: Label = $CanvasLayer/CountdownLabel
@onready var enemy_spawner = $EnemySpawner

var max_wave = 5 # This will be the boss wave.
var current_wave = 1

func _ready():
	# Set initial totem masks.
	var totens = $Totens.get_children()
	totens.shuffle()

	for i in range(totens.size()):
		totens[i].select_mask(i)

	add_child(timer)

	timer.one_shot = true
	timer.start(starter_countdown_time)

	start_countdown()

func start_countdown():
	countdown_label.visible = true

	for i in range(starter_countdown_time, 0, -1):
		countdown_label.text = 'Next Wave in: ' + str(i)
		await get_tree().create_timer(1.0).timeout
	countdown_label.text = "GO!"
	await get_tree().create_timer(0.5).timeout
	countdown_label.visible = false

	on_countdown_finished()

func on_countdown_finished():
	curr_game_stage = game_state.stages.PLAYING

	if current_wave == max_wave:
		enemy_spawner.start_boss()

	else:
		enemy_spawner.start(current_wave)

func change_wave():
	if current_wave == max_wave:
		curr_game_stage = game_state.stages.VICTORY
		$Player.won.emit()
		
	else:
		curr_game_stage = game_state.stages.COUNTING_DOWN_TO_START
		current_wave += 1

		timer.start(starter_countdown_time)

		start_countdown()
