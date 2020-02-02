extends Resource


export(PoolStringArray) var puzzles_paths

func get_new_puzzle():
	return load(puzzles_paths[randi() % puzzles_paths.size()])
