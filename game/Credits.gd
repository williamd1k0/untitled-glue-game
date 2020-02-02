extends Control


export(String, FILE, '*.tscn') var back_scene

func _ready():
	$Button.grab_focus()


func _on_Button_pressed():
	get_tree().change_scene(back_scene)
