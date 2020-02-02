extends Node


onready var hud = $InterfaceLayer/HUD
onready var game_over_screen = $InterfaceLayer/GameOverScreen
var score = 0 setget set_score

func _ready():
	set_score(0)


func set_score(value):
	score = value
	hud.set_score_text(score)


func _on_Puzzle_piece_fit(piece_position, fit_score):
	set_score(score + fit_score)
	hud.create_pop_label(piece_position, fit_score)


func _on_Time_finished():
	BGM.start_effect("game_over")
	game_over_screen.set_final_score(score)
	game_over_screen.show()
	get_tree().paused = true
