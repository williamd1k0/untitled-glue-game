extends Control

export(String, FILE, '*.tscn') var game_scene
export(String, FILE, '*.tscn') var credits_scene

func _ready():
	$Menu/Play.grab_focus()

func _on_Play_pressed():
	get_tree().change_scene(game_scene)


func _on_Credits_pressed():
	get_tree().change_scene(credits_scene)


func _on_Quit_pressed():
	get_tree().quit()
