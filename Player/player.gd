extends CharacterBody3D

@onready var player_mesh = $PlayerMesh

func set_velocity_from_motion(vel: Vector3) -> void:
	var walk_dir = Vector2(vel.x, -vel.z).rotated(-global_rotation.y).normalized()
	player_mesh.set_walk_direction(walk_dir)
	velocity.y = vel.y

func _input(event):
	if event.is_action_pressed("shoot"):
		player_mesh.activate_shoot()

#basic movement
func _process(delta: float) -> void:
	var current_rotation = transform.basis.get_rotation_quaternion()
	var target_velocity = (current_rotation.normalized() * player_mesh.get_root_pos()) / delta
	velocity.x = -target_velocity.x
	velocity.z = -target_velocity.z
	move_and_slide()
