extends KinematicBody2D

enum HandMode {
	LEFT, RIGHT
}

enum {
	HORIZONTAL,
	VERTICAL,
	TRIGGER,
}
const JOYMAP = {
	HandMode.LEFT: [JOY_AXIS_0, JOY_AXIS_1, JOY_AXIS_6],
	HandMode.RIGHT: [JOY_AXIS_2, JOY_AXIS_3, JOY_AXIS_7],
}
const ANIM_MAP = {
	false: 'idle',
	true: 'grab',
}

export(HandMode) var hand = HandMode.LEFT
export(float) var speed = 500
var deadzone = 0.3
var grabbing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var grab = Input.get_joy_axis(0, JOYMAP[hand][TRIGGER]) >= 0.9
	if grabbing != grab:
		grabbing = grab
		$AnimationPlayer.play(ANIM_MAP[grabbing])

	var input_motion := Vector2(
		Input.get_joy_axis(0, JOYMAP[hand][HORIZONTAL]),
		Input.get_joy_axis(0, JOYMAP[hand][VERTICAL])
	)
	if abs(input_motion.x) < deadzone:
		input_motion.x = 0
	if abs(input_motion.y) < deadzone:
		input_motion.y = 0
	#print(input_motion)
	move_and_collide(input_motion*speed*delta)
