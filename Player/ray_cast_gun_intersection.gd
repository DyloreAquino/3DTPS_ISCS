extends RayCast3D

var current: Vector3

@onready var camera_ray: RayCast3D = $"../../Camera System/EdgeSpring/RearSpring/Camera3D/RayCastCam"

func _process(delta: float) -> void:
	current.x = camera_ray.get_collision_point().x
	current.y = camera_ray.get_collision_point().y * -90
	current.z = camera_ray.get_collision_point().z
	self.target_position = current

func _camera_ray_cast(_range: float = 100) -> Vector3:
	var viewport_size: Vector2i
	var window: Window = get_window()
	
	match window.content_scale_mode:
		window.CONTENT_SCALE_MODE_VIEWPORT:
			viewport_size = window.content_scale_size
		window.CONTENT_SCALE_MODE_CANVAS_ITEMS:
			viewport_size = window.content_scale_size
		window.CONTENT_SCALE_MODE_DISABLED:
			viewport_size = window.get_size()
		
	var camera: Camera3D = get_viewport().get_camera_3d()
	
	var ray_origin: Vector3 = self.position
	var ray_end: Vector3 = ray_origin + camera.project_ray_normal(viewport_size / 2) * _range 
	
	var new_ray_query: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	new_ray_query.set_hit_from_inside(false)
	
	var intersection: Dictionary = get_world_3d().direct_space_state.intersect_ray(new_ray_query)
	
	if not intersection.is_empty():
		var collision: Vector3 = intersection.position
		return collision
	else:
		return ray_end
