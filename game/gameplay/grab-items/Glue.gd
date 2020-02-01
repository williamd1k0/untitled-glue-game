extends GrabItem

export(Resource) var charge
export(float) var squeeze_ratio = 10.0


func _ready():
	charge.connect("depleted", self, "_on_charge_depleted")

func _process(delta):
	squeeze(delta)


func squeeze(delta):
	if grabber == null:
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
