extends RayCast3D

@onready var player_mesh = $"../../../../.."


func _physics_process(delta):
	player_mesh.camera_ray.force_raycast_update()
	target_position = Vector3.ZERO
	if player_mesh.camera_ray.is_colliding():
		target_position = to_local(player_mesh.camera_ray.get_collision_point())
	force_raycast_update()
