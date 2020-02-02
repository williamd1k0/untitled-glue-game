extends Node


export(float, EASE) var difficulty = 1.0
export(float, EASE) var time_difficulty = 1.0

onready var hud = $InterfaceLayer/HUD
onready var game_over_screen = $InterfaceLayer/GameOverScreen
var score = 0 setget set_score

func _ready():
	set_score(0)
	BGM.reverse_effect("high_pass")


func set_score(value):
	score = value
	hud.set_score_text(score)


func _on_Puzzle_piece_fit(piece_position, fit_score):
	set_score(score + fit_score)
	hud.create_pop_label(piece_position, fit_score)


func _on_Time_finished():
	$SFXTimeOut.play()
	BGM.start_effect("high_pass")
	$InterfaceLayer/HUD.hide()
	game_over_screen.set_final_score(score)
	game_over_screen.show()
	get_tree().paused = true


func _on_Puzzle_tree_exited():
	var spawn_count = $LevelLayer/Level/PuzzleSpawner.spawn_count
	var time = $Time.time
	time.left += 15 - (spawn_count * time_difficulty)
	var puzzle = $LevelLayer/Level/PuzzleSpawner.spawn()
	puzzle.connect("tree_exited", self, "_on_Puzzle_tree_exited")
	puzzle.connect("piece_fit", self, "_on_Puzzle_piece_fit")
	puzzle.score *= spawn_count * difficulty
	puzzle.score = round(puzzle.score)
