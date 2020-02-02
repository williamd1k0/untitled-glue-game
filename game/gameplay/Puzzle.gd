extends Node2D

signal piece_fit(piece_position, fit_score)

var RNG: RandomNumberGenerator = RandomNumberGenerator.new()

export(Gradient) var palette: Gradient = preload("res://game/puzzles/piece-colors.tres")
export(int) var score = 100
var fit_pieces = []
var pieces_total = 0
var fit_area := Node2D.new()
var tween := Tween.new()
var puzzle_color: Color

func _ready():
	add_child(fit_area)
	add_child(tween)
	tween.connect("tween_all_completed", self, "_on_Tween_all_completed")
	RNG.randomize()
	puzzle_color = palette.colors[RNG.randi() % palette.colors.size()]
	create_fit_areas()
	$Pieces.position = $DropPos.position

func create_fit_areas():
	for piece in $Pieces.get_children():
		pieces_total += 1
		piece.tint(puzzle_color)
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
	var area: Area2D = get_fit_area(piece_id)
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
	emit_signal("piece_fit", piece_pos, score)
	$SFXPieceFit.play()
	piece.destroy()


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
		#fit_area.z_index -= 1
		yield(get_tree().create_timer(0.3), "timeout")
		$RefPosition.modulate = puzzle_color
		fit_area.hide()
		$AnimationPlayer.play("completed")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "completed":
		queue_free()
