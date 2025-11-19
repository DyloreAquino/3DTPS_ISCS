extends RigidBody3D

var ex = preload("res://World/explosion.tscn")

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	var plosion = ex.instantiate()
	plosion.global_position = self.global_position
	get_tree().current_scene.add_child(plosion)
	queue_free()
	
	
