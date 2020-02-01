extends GrabItem

signal glue_amount_changed(new_amount)

export(float) var max_glue = 200.0
export(float) var squeeze_amount_per_second = 10.0

var current_glue
var depleted = false

func _ready():
	current_glue = max_glue


func _process(delta):
	squeeze(delta)


func squeeze(delta):
	if grabber == null:
		return
	if current_glue <= 0:
		depleted = true
		collision_layer = 0
		collision_mask = 0
		grabber.release()
		return
	current_glue -= squeeze_amount_per_second * delta
	emit_signal("glue_amount_changed", current_glue)


func can_grab():
	return .can_grab() and not depleted
