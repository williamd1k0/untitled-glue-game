extends Line2D

export (NodePath) var reference_path
onready var reference = get_node(reference_path)

func _process(delta):
	points[get_point_count() -1] = to_local(reference.global_position)
	var angle = rad2deg(points[0].angle_to(points[get_point_count() -1]))
