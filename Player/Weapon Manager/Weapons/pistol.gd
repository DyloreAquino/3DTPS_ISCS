extends Node3D
class_name Pistol

@export var bullet_point: Marker3D
@export var current_ammo: Ammo

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		print("Shoot")
		$RigidBodyProjectile._set_weapon_projectile(self)
