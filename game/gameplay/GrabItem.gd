class_name GrabItem
extends RigidBody2D

signal release

var grabber


func _integrate_forces(state):
	if grabber != null:
		state.transform = grabber.grab_position.global_transform

func grab(hand):
	gravity_scale = 0
	grabber = hand
	rotation = 0
	collision_layer &= ~1
	collision_mask &= ~1
	$Animator.play("grab")

func release():
	grabber = null
	gravity_scale = 1
	collision_layer |= 1
	collision_mask |= 1
	$Animator.play("idle")
	emit_signal("release")

func has_grabber():
	return grabber != null

func can_grab():
	return not has_grabber()
