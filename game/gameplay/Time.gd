extends Resource

signal depleted
signal time_changed(left_time)

export(float) var max_time = 1.0

var left = 1.0 setget set_left

func set_left(value):
	left = value
	left = clamp(left, 0.0, max_time)
	emit_signal("time_changed", left)
	if left == 0.0:
		emit_signal("depleted")
