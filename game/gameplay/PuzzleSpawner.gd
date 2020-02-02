extends Node2D

const MEDIUM_THRESHOLD = 2
const HARD_THRESHOLD = 5

export(Resource) var puzzles
export(NodePath) var container

var spawn_count = 1

func _ready():
	randomize()


func spawn():
	var puzzle_scene = puzzles.get_new_puzzle()
	var puzzle = puzzle_scene.instance()
	get_node(container).add_child(puzzle)
	increment_spawn()
	return puzzle


func increment_spawn():
	if spawn_count > 5:
		return
	spawn_count += 1
	match spawn_count:
		MEDIUM_THRESHOLD:
			puzzles = load("res://game/gameplay/PuzzlesMedium.tres")
		HARD_THRESHOLD:
			puzzles = load("res://game/gameplay/PuzzlesHard.tres")
