extends Control

func _on_exit_pressed():
	get_tree().paused = false
	self.visible = false
	get_tree().change_scene_to_file("res://menus/MainMenu.tscn")

func _on_player_died():
	$Label.text = "GAME OVER!"
	get_tree().paused = true
	self.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_player_won():
	$Label.text = "VICTORY!"
	get_tree().paused = true
	self.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
