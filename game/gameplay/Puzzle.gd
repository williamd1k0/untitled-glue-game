extends Node2D


#func _enter_tree():
	#$PuzzleRef.hide()
	#$PuzzleRef.queue_free()

func _enter_tree():
	create_fit_objects()

func _ready():
	$Pieces.position = $DropPos.position

func create_fit_objects():
	for piece in $Pieces.get_children():
		print(piece.position)
		var area := Area2D.new()

