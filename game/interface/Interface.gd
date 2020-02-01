extends Control


export (NodePath) var glue_path
onready var glue = get_node(glue_path)

onready var glue_bar = $GlueAmountBar

func _ready():
	glue_bar.max_value = glue.max_glue
	glue_bar.value = glue.current_glue
	
	glue.connect("glue_amount_changed", self, "_on_Glue_amount_changed")


func _on_Glue_amount_changed(amount):
	glue_bar.value = amount

