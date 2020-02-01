class_name Piece
extends GrabItem

const GLUE_MASK = 4

export(PoolIntArray) var dependencies
var glue = 0
var glue_max = 6
var glue_consume = 0.05

onready var sprite = $Sprite

func _ready():
	sprite.material = sprite.material.duplicate(true)

func _process(delta):
	if has_node("Sprite"):
		if glue > 0:
			glue -= glue_consume
		(sprite.material as ShaderMaterial).set_shader_param('aura_width', glue)

func has_glue():
	return glue > 0

func get_id():
	return int(sprite.animation)

func release_sprite():
	remove_child(sprite)
	return sprite

func add_glue(amount):
	glue = min(glue_max, glue+amount)

func grab(hand):
	.grab(hand)
	collision_layer |= GLUE_MASK

func release():
	.release()
	collision_layer &= ~GLUE_MASK

func destroy():
	hide()
	collision_layer = 0
	collision_mask = 0
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()
