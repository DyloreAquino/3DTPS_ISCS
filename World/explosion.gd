extends Node3D

func _ready() -> void:
	$Debris.restart()
	$Fire.restart()

func _on_cpu_particles_3d_finished() -> void:
	print("done")
	queue_free()
