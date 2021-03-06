extends Control

export (Resource) var glue_charge
export (Resource) var time
export (PackedScene) var pop_label_scene

onready var glue_bar = $GlueAmountBar
onready var clock = $TimeProgressBar
onready var score_label = $Label

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


func create_pop_label(label_position, label_text):
	var pop_label = pop_label_scene.instance()
	pop_label.text = "%s" % label_text
	add_child(pop_label)
	pop_label.rect_position = label_position


func set_score_text(text):
	score_label.text = "%s" % text
