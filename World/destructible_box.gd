extends RigidBody3D

var HP: int = 3
@onready var bullet: Node3D = $RigidBodyProjectilepreload

func _physics_process(delta: float) -> void:
	if HP <= 0:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body == bullet:
		HP -= 1
		print(HP)
