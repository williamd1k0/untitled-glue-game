class_name GrabItem
extends RigidBody2D

signal release

var grabber


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	#translate(Vector2(0, 0))
	pass

func _integrate_forces(state):
	if grabber != null:
		state.transform = grabber.grab_position.global_transform

func grab(hand):
	#collision_mask = 0
	#collision_layer = 0
	gravity_scale = 0
	grabber = hand
	rotation = 0
	$Animator.play("grab")

func release():
	grabber = null
	#collision_mask = 1
	#collision_layer = 1
	gravity_scale = 1
	$Animator.play("idle")
	emit_signal("release")

func has_grabber():
	return grabber != null

func can_grab():
	return not has_grabber()
