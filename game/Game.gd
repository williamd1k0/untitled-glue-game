extends Node


onready var interface = $InterfaceLayer/Interface
var score = 0 setget set_score

func _ready():
	set_score(0)


func set_score(value):
	score = value
	interface.set_score_text(score)


func _on_Puzzle_piece_fit(piece_position, fit_score):
	set_score(fit_score)
	interface.create_pop_label(piece_position, fit_score)


func _on_Time_finished():
	get_tree().quit()
