class_name GrabItem
extends Area2D


var grabbed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func grab(hand):
	grabbed = hand

func release():
	grabbed = null
