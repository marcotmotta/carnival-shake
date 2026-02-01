extends Control

func _input(event):
	if Input.is_action_just_pressed("esc"):
		if not get_tree().paused:
			pause_game()
		else:
			unpause_game()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	$MarginContainer/Wave.text = 'WAVE: ' + str(get_tree().get_first_node_in_group('world').current_wave)

func pause_game():
	get_tree().paused = true
	self.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func unpause_game():
	get_tree().paused = false
	self.visible = false

func _on_resume_button_pressed():
	unpause_game()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_quit_button_pressed():
	get_tree().quit()
