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

var item_to_grab: GrabItem
var grabbed_item: GrabItem


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
	#print(input_motion)
	translate(input_motion*speed*delta)
	#if grabbed_item:
	#	grabbed_item.global_position = $GrabPosition.global_position

func grab():
	if item_to_grab and not item_to_grab.grabbed:
		grabbed_item = item_to_grab
		grabbed_item.grab($GrabPosition)
		print('grab item')
		emit_signal("grab")

func release():
	if grabbed_item:
		grabbed_item.release()
		grabbed_item = null
		emit_signal("release")

func _on_area_entered(area):
	if area is GrabItem:
		item_to_grab = area

func _on_area_exited(area):
	if area == item_to_grab:
		item_to_grab = null

func _on_body_entered(body):
	if body is GrabItem:
		item_to_grab = body

func _on_body_exited(body):
	if not grabbed_item and body == item_to_grab:
		item_to_grab = null
