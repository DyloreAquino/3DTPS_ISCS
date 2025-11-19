extends Projectile
class_name RigidBodyProjectile

@export var projectile_velocity: float = 10.0
@export var rigid_body_bullet: PackedScene

var camera_collision: Vector3

func _set_weapon_projectile(weapon: Pistol) -> void:
	self.camera_collision.x = _camera_ray_cast().x
	self.camera_collision.y = _camera_ray_cast().y
	self.camera_collision.z = _camera_ray_cast().z
	launch_rigid_body_projectile(camera_collision, weapon, rigid_body_bullet)

func launch_rigid_body_projectile(point: Vector3, weapon: Pistol, bullet: PackedScene) -> void:
	var _projectile: RigidBody3D = bullet.instantiate()
	
	get_tree().current_scene.add_child(_projectile)
	
	_projectile.global_position = weapon.bullet_point.global_position
	
	_projectile.look_at(point)
	
	var direction: Vector3 = (point - weapon.bullet_point.global_position).normalized()
	_projectile.set_linear_velocity(direction * projectile_velocity)
