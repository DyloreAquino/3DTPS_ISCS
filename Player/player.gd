extends CharacterBody3D


func set_velocity_from_motion(vel: Vector3) -> void:
	velocity = vel

#basic movement
func _physics_process(delta: float) -> void:
	move_and_slide()
