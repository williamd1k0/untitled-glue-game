class_name Piece
extends GrabItem


export(PoolIntArray) var dependencies
var glue = 0

func has_glue():
	return glue > 0

func get_id():
	return int($Sprite.animation)

func release_sprite():
	var sprite = $Sprite
	remove_child(sprite)
	return sprite
