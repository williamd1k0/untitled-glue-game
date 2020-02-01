extends RayCast2D

export(float) var glue_amount = 5


func _physics_process(delta):
	if enabled and is_colliding():
		var piece: Piece = get_collider()
		piece.add_glue(glue_amount * delta)
