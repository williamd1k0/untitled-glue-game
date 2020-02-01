extends Control

export (Resource) var glue_charge

onready var glue_bar = $GlueAmountBar

func _ready():
	glue_bar.max_value = glue_charge.max_amount
	glue_bar.value = glue_charge.current_amount
	
	glue_charge.connect("amount_changed", self, "_on_Glue_amount_changed")


func _on_Glue_amount_changed(amount):
	glue_bar.value = amount

