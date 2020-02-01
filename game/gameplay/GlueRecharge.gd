extends Node

export(Resource) var glue_charge
export(float) var ratio = 10.0

func _ready():
	glue_charge.connect("depleted", self, "set_process", [true])
	glue_charge.connect("recharged", self, "set_process", [false])
	set_process(false)


func _process(delta):
	glue_charge.current_amount += ratio * delta
