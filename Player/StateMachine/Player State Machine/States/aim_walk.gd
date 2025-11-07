extends Motion

signal aim_enter
signal aim_exit

func _enter() -> void:
	aim_enter.emit()
	print(name)

func _state_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		aim_exit.emit()
		finished.emit("Jump")
	
	if event.is_action_pressed("sprint"):
		finished.emit("Sprint")
	
	if event.is_action_released("aim"):
		aim_exit.emit()
		finished.emit("Run")

func _update(delta: float) -> void:
	set_direction()
	calculate_velocity(aim_spd, direction, PLAYER_MOVEMENT_STATS.acceleration, delta)
	
	if direction == Vector3.ZERO:
		finished.emit("AimIdle")
		
	if not is_on_floor():
		aim_exit.emit()
		finished.emit("Fall")
