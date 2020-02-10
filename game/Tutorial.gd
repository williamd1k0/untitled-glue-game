extends Node


onready var tutorial_piece = $LevelLayer/Level/Puzzle/Pieces/Piece3
onready var piece_reference = $TutorialPieceReference

func _ready():
	tutorial_piece.global_position = piece_reference.global_position


func _on_Puzzle_completed():
	get_tree().paused = true
	$TutorialLayer/Instructions/Congratulations.show()
	$TutorialLayer/Instructions/HBoxContainer.hide()
	$TutorialLayer/Instructions/Congratulations/PlayButton.grab_focus()


func _on_PlayButton_pressed():
	var animator = $TutorialLayer/Instructions/Fade/AnimationPlayer
	animator.play_backwards("fade")
	yield(animator, "animation_finished")
	get_tree().paused = false
	get_tree().change_scene("res://game/Game.tscn")
