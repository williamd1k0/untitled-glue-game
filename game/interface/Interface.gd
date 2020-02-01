extends Control

export (Resource) var glue_charge
export (Resource) var time

onready var glue_bar = $GlueAmountBar
onready var clock = $TimeProgressBar

func _ready():
	glue_bar.max_value = glue_charge.max_amount
	glue_bar.value = glue_charge.current_amount
	
	glue_charge.connect("amount_changed", self, "_on_Glue_amount_changed")
	
	time.connect("time_changed", self, "_on_Time_changed")
	clock.max_value = time.max_time


func _on_Glue_amount_changed(amount):
	glue_bar.value = amount


func _on_Time_changed(value):
	clock.value = value