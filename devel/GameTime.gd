extends Node

signal finished

export(Resource) var time

func _ready():
	time.left = time.max_time
	time.connect("depleted", self, "_on_Time_depleted")


func _process(delta):
	time.left -= delta


func _on_Time_depleted():
	emit_signal("finished")
