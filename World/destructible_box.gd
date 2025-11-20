extends Node3D

func die():
	$AudioStreamPlayer3D.play()
	$RigidBody3D.queue_free()
	await get_tree().create_timer(1.0).timeout
	queue_free()
