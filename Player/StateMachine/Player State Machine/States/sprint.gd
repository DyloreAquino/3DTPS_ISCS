extends Motion

signal sprint_start
signal sprint_end

func _enter() -> void:
	sprint_start.emit()
	print(name)

func _state_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		finished.emit("SprintJump")
	
	if event.is_action_released("sprint"):
		sprint_end.emit()
		finished.emit("Run")

func _update(delta: float) -> void:
	set_direction()
	calculate_velocity(sprint_spd, direction, PLAYER_MOVEMENT_STATS.acceleration, delta)
	
	if direction == Vector3.ZERO:
		sprint_end.emit()
		finished.emit("Idle")
	
