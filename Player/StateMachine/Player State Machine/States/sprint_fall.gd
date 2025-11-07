extends Motion

signal sprint_end

func _enter() -> void:
	print(name)

func _update(delta: float) -> void:
	set_direction()
	calculate_gravity(delta)
	calculate_velocity(sprint_spd, direction, PLAYER_MOVEMENT_STATS.in_air_acceleration, delta)
	
	if is_on_floor():
		if Input.is_action_pressed("sprint"):
			finished.emit("Sprint")
		elif direction != Vector3.ZERO:
			sprint_end.emit()
			finished.emit("Run")
		else:
			sprint_end.emit()
			finished.emit("Idle")
