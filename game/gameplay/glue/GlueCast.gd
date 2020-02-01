extends RayCast2D

export(float) var glue_amount = 0.2


func start():
	enabled = true

func stop():
	enabled = false

func _physics_process(delta):
	if enabled and is_colliding():
		var piece: Piece = get_collider()
		piece.add_glue(glue_amount)
		prints('adding glue to', piece.get_id())
