class_name Piece
extends GrabItem


export(PoolIntArray) var dependencies


func get_id():
	return int($Sprite.animation)


func release_sprite():
	var sprite = $Sprite
	remove_child(sprite)
	return sprite
