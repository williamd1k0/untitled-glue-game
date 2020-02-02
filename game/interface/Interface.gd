extends Control

export (Resource) var glue_charge
export (Resource) var time
export (PackedScene) var pop_label_scene

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


func _on_Puzzle_piece_fit(piece_position, piece_score):
	var pop_label = pop_label_scene.instance()
	pop_label.text = "%s" % piece_score
	add_child(pop_label)
	pop_label.rect_position = piece_position
