extends AudioStreamPlayer

const Effects = {"high_pass": 0}
export(AudioEffect) var high_pass
var bus_index = 0

func _ready():
	bus_index = AudioServer.get_bus_index(bus)
	
func start_effect(effect):
	$AnimationPlayer.play(effect)


func enable_effect(effect_name, enable):
	AudioServer.set_bus_effect_enabled(bus_index, Effects[effect_name], enable)
