extends Resource

signal amount_changed(current_amount)
signal depleted
signal recharged

export (float) var max_amount = 30

var current_amount = 0 setget set_amount

func _init():
	current_amount = max_amount


func set_amount(amount):
	current_amount = amount
	current_amount = clamp(current_amount, 0, max_amount)
	emit_signal("amount_changed", current_amount)
	if  current_amount == 0:
		emit_signal("depleted")
	elif current_amount == max_amount:
		emit_signal("recharged")
