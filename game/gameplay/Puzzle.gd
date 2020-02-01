extends Node2D

var fit_pieces = []
var pieces_total = 0
var fit_area := Node2D.new()
var tween := Tween.new()

func _enter_tree():
	pass

func _ready():
	add_child(fit_area)
	add_child(tween)
	tween.connect("tween_all_completed", self, "_on_Tween_all_completed")
	create_fit_objects()
	$Pieces.position = $DropPos.position

func create_fit_objects():
	for piece in $Pieces.get_children():
		pieces_total += 1
		prints(piece.get_id(), piece.position)
		var area := preload("res://game/gameplay/FitArea.tscn").instance()
		fit_area.add_child(area)
		area.global_position = piece.global_position
		area.piece_id = piece.get_id()
		area.connect("body_entered", self, "_on_FitArea_body_entered", [area.piece_id])
		piece.connect("release", self, "_on_Piece_release", [piece])

func get_fit_area(piece_id):
	for area in fit_area.get_children():
		if area.piece_id == piece_id:
			return area

func fit_piece(piece: Piece):
	var piece_id = piece.get_id()
	fit_pieces.append(piece_id)
	prints(piece_id, 'fit')
	#piece.fit(get_fit_area(piece.get_id()).global_position)
	var area = get_fit_area(piece_id)
	var sprite: AnimatedSprite = piece.release_sprite()
	var piece_pos = piece.global_position
	sprite.scale = Vector2(1, 1) # workaround :P
	area.add_child(sprite)
	tween.interpolate_property(
		sprite, 'global_position',
		piece_pos, area.global_position,
		0.2, Tween.TRANS_BACK, Tween.EASE_IN
	)
	tween.start()
	piece.queue_free()

func check_piece(piece: Piece):
	if piece.has_glue() and not piece.has_grabber():
		var depends = piece.dependencies
		if depends.size():
			for id in depends:
				if not id in fit_pieces:
					return # Needs dependencies to be fit before
		fit_piece(piece)

func _on_Piece_release(piece: Piece):
	var area: Area2D = get_fit_area(piece.get_id())
	if area.overlaps_body(piece):
		check_piece(piece)

func _on_FitArea_body_entered(body, piece_id):
	if piece_id in fit_pieces:
		return
	if body is Piece and piece_id == body.get_id():
		check_piece(body)

func _on_Tween_all_completed():
	if fit_pieces.size() == pieces_total:
		$PuzzleRef/AnimationPlayer.play("done")
