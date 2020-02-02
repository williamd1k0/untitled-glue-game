extends Control

export(String, FILE, '*.tscn') var game_scene

func _on_Play_pressed():
	get_tree().change_scene(game_scene)

func _on_Quit_pressed():
	get_tree().quit()
