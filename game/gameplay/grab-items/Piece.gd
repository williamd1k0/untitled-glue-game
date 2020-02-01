class_name Piece
extends GrabItem


export(PoolIntArray) var dependencies


func get_id():
	return int($Sprite.animation)
