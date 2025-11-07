extends Motion

func _enter() -> void:
	print(name)

func _update(delta: float) -> void:
	set_direction()
	calculate_velocity(SPEED, direction, delta)
	
	if direction != Vector3.ZERO:
		finished.emit("Run")
	
	if not is_on_floor():
		finished.emit("Fall")
