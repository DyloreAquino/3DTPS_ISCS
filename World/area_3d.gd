extends Area3D

var ex = preload("res://World/explosion.tscn")

func _on_body_entered(body):
	if body is Bullet:
		print("yo")
		destroy_bullet(body)
		$"../..".die()


func destroy_bullet(bullet):
	var plosion = ex.instantiate()
	get_tree().current_scene.add_child(plosion)
	plosion.global_position = bullet.global_position
	plosion.emit_explosion(true)
	bullet.queue_free()
