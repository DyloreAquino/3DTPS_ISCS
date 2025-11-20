extends Node3D
class_name Pistol

@export var bullet_point: Marker3D
@export var current_ammo: Ammo

var shootTimer: float = 1.0
var isShooting: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("swap_cam"):
		print("Swap")
		$".".position.x = -position.x

func _process(delta):
	if Input.is_action_pressed("shoot"):
		if isShooting:
			shootTimer += delta
			if shootTimer > 0.15:
				$AudioStreamPlayer3D.play()
				$RigidBodyProjectile._set_weapon_projectile(self)
				shootTimer = 0.0
		else:
			$AudioStreamPlayer3D.play()
			$RigidBodyProjectile._set_weapon_projectile(self)
			isShooting = true
			shootTimer = 0.0
	if Input.is_action_just_released("shoot"):
		isShooting = false
