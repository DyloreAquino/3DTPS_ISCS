extends Node3D

func emit_explosion(hit_enemy = false):
	$Fire.restart()
	if hit_enemy:
		$Debris.restart()

func _on_cpu_particles_3d_finished() -> void:
	print("done")
	queue_free()
