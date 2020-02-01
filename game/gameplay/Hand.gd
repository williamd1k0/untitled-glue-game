class_name Hand
extends Area2D

signal grab
signal release

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

var grabbed_item: GrabItem

onready var grab_position = $GrabPosition


func _physics_process(delta):
	var grab := Input.get_joy_axis(0, JOYMAP[hand][TRIGGER]) >= 0.9
	if grabbing != grab:
		grabbing = grab
		$Animator.play(ANIM_MAP[grabbing])
		if grabbing:
			grab()
		else:
			release()

	var input_motion := Vector2(
		Input.get_joy_axis(0, JOYMAP[hand][HORIZONTAL]),
		Input.get_joy_axis(0, JOYMAP[hand][VERTICAL])
	)
	if abs(input_motion.x) < deadzone:
		input_motion.x = 0
	if abs(input_motion.y) < deadzone:
		input_motion.y = 0
	translate(input_motion*speed*delta)

func find_grab_item():
	var bodies = get_overlapping_bodies()
	if bodies.size():
		for body in bodies:
			if body is GrabItem and body.can_grab():
				return body

func grab():
	var item = find_grab_item()
	if item:
		grabbed_item = item
		grabbed_item.grab(self)
		print('grab item')
		emit_signal("grab")

func release():
	if grabbed_item:
		grabbed_item.release()
		grabbed_item = null
		emit_signal("release")
