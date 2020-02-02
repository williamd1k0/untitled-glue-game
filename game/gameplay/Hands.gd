extends Node2D


func _ready():
	var points = $Boundaries.polygon
	var bounds = Rect2(points[0], points[2]-points[0])
	$LeftHand.set_boundaries(bounds)
	$RightHand.set_boundaries(bounds)
