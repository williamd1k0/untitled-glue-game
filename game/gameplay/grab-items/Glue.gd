extends GrabItem

export(Resource) var charge
export(float) var squeeze_ratio = 10.0


func _ready():
	charge.connect("depleted", self, "_on_charge_depleted")
	charge.current_amount = charge.max_amount

func _process(delta):
	squeeze(delta)

func squeeze(delta):
	if grabber == null:
		$GlueCast.enabled = false
		return
	charge.current_amount -= squeeze_ratio * delta
	$GlueCast.enabled = charge.current_amount > 0

func can_grab():
	return .can_grab() and charge.current_amount > 0


func _on_charge_depleted():
	collision_layer = 0
	collision_mask = 0
	if grabber != null:
		grabber.release()


func _on_VisibilityNotifier2D_screen_exited():
	charge.deplete()
	queue_free()
