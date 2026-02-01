extends Node3D

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://World.tscn")

func _on_instructions_button_pressed():
	$CanvasLayer/InstructionsPanel.visible = true

func _on_credits_button_pressed():
	$CanvasLayer/CreditsPanel.visible = true

func _on_exit_button_pressed():
	get_tree().quit()

func _on_back_button_pressed():
	$CanvasLayer/InstructionsPanel.visible = false
	$CanvasLayer/CreditsPanel.visible = false
