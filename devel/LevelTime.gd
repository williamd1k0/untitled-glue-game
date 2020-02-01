extends Node

signal finished

export(Resource) var time

func _ready():
	time.left = time.max_time


func _process(delta):
	time.left -= delta
