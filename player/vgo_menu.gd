extends Control

func _on_player_died():
	$MarginContainer/GameOverImage.visible = true
	get_tree().paused = true
	self.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_player_won():
	$MarginContainer/VictoryImage.visible = true
	get_tree().paused = true
	self.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_restart_button_pressed():
	get_tree().paused = false
	$MarginContainer/GameOverImage.visible = false
	$MarginContainer/VictoryImage.visible = false
	self.visible = false
	get_tree().change_scene_to_file("res://menus/MainMenu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
