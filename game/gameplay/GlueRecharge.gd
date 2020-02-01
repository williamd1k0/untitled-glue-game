extends Node

export(Resource) var glue_charge
export(float) var ratio = 10.0

func _ready():
	glue_charge.connect("depleted", self, "_on_GlueCharge_depleted")
	glue_charge.connect("recharged", self, "_on_GlueCharge_recharged")
	set_process(false)


func _process(delta):
	glue_charge.current_amount += ratio * delta


func _on_GlueCharge_depleted():
	set_process(true)
	glue_charge.recharging = true


func _on_GlueCharge_recharged():
	set_process(false)
	glue_charge.recharging = false

