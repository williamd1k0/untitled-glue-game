class_name Hand
extends Area2D

signal grab
signal release

enum HandMode {
	LEFT, RIGHT
}

const ACTIONS = {
	HandMode.LEFT: ["left_up", "left_down", "left_left", "left_right", "left_grab"],
	HandMode.RIGHT: ["right_up", "right_down", "right_left", "right_right", "right_grab"]
}
const ANIM_MAP = {
	false: 'idle',
	true: 'grab',
}

export(HandMode) var hand = HandMode.LEFT
export(float) var speed = 500
var deadzone = 0.3
var grabbing = false
var boundaries: Rect2
var grabbed_item: GrabItem
var is_moving = false

onready var grab_position = $GrabPosition
onready var animator = $Animator


func _physics_process(delta):
	detect_grab()
	move(delta)


func detect_grab():
	var grab := Input.is_action_pressed(ACTIONS[hand][4])
	if grabbing != grab:
		grabbing = grab
		animator.play(ANIM_MAP[grabbing])
		if grabbing:
			grab()
		else:
			release()


func get_movement_direction():
	var direction = Vector2(
		Input.get_action_strength(ACTIONS[hand][3]) - Input.get_action_strength(ACTIONS[hand][2]),
		Input.get_action_strength(ACTIONS[hand][1]) - Input.get_action_strength(ACTIONS[hand][0])
	)
	return direction


func move(delta):
	var input_motion = get_movement_direction()
	
	var motion: Vector2 = input_motion*speed*delta
	if boundaries:
		var bo = boundaries
		var motion_test: Vector2 = grab_position.global_position+motion
		if not bo.has_point(motion_test):
			motion_test = Vector2(
				clamp(motion_test.x, bo.position.x, bo.end.x),
				clamp(motion_test.y, bo.position.y, bo.end.y)
			)
			motion = motion_test - grab_position.global_position
	if is_moving:
		rotation_degrees = lerp(rotation_degrees, 70 * -sign(motion.x), 3 * delta)
	else:
		rotation_degrees = lerp(rotation_degrees, 0, 5 * delta)
	translate(motion)
	is_moving = not motion.x == 0.0


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

func release(reset_collision=true):
	if grabbed_item:
		grabbed_item.release(reset_collision)
		grabbed_item = null
		emit_signal("release")

func set_boundaries(rect):
	boundaries = rect
