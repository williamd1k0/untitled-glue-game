extends Node


const SAVE_FILE = 'user://score.local'
const SAVE_PASS = 'Imposto é roubo'
var fs: File = File.new()

var best_score = 0

func _ready():
	load_score()

func load_score():
	var dir = Directory.new()
	if dir.file_exists(SAVE_FILE):
		fs.open_encrypted_with_pass(SAVE_FILE, File.READ, SAVE_PASS)
		best_score = fs.get_var()
		fs.close()

func save_score():
	fs.open_encrypted_with_pass(SAVE_FILE, File.WRITE, SAVE_PASS)
	fs.store_var(best_score)
	fs.close()
