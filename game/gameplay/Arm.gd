extends Line2D

export (NodePath) var reference_path
onready var reference = get_node(reference_path)

func _process(delta):
	points[1] = to_local(reference.global_position)
