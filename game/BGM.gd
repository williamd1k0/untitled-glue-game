extends AudioStreamPlayer

const Effects = {"high_pass": 0}
export(AudioEffect) var high_pass
var bus_index = 0

func _ready():
	bus_index = AudioServer.get_bus_index(bus)
	
func start_effect(effect):
	if is_effect_enabled(effect):
		return
	enable_effect(effect, true)
	$AnimationPlayer.play(effect)


func stop_effect(effect):
	$AnimationPlayer.stop()
	enable_effect(effect, false)


func reverse_effect(effect):
	if not is_effect_enabled(effect):
		return
	$AnimationPlayer.play_backwards(effect)
	yield($AnimationPlayer, "animation_finished")
	stop_effect(effect)


func enable_effect(effect_name, enable):
	AudioServer.set_bus_effect_enabled(bus_index, Effects[effect_name], enable)


func is_effect_enabled(effect_name):
	var enabled = AudioServer.is_bus_effect_enabled(bus_index, Effects[effect_name])
	return enabled
