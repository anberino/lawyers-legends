extends Control

func _on_Play_pressed():
	get_tree().change_scene("res://Levels/Game/Game.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func _on_Credits_pressed():
	get_tree().change_scene("res://Levels/Credits/Credits.tscn")
