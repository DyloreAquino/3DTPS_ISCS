extends RigidBody3D
class_name Bullet

var ex = preload("res://World/explosion.tscn")

func _on_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	var plosion = ex.instantiate()
	get_tree().current_scene.add_child(plosion)
	plosion.global_position = self.global_position
	plosion.emit_explosion(body.is_in_group("Enemy"))
	$MeshInstance3D.visible = false
	call_deferred("disable_colision")
	if body.is_in_group("Enemy"):
		$hit_enemy.play()
	else:
		$hit_not_enemy.play()
	await get_tree().create_timer(0.8).timeout
	queue_free()
	
func play_audios():
	$MeshInstance3D.visible = false
	call_deferred("disable_colision")
	$hit_not_enemy.play()
	$hit_enemy.play()
	await get_tree().create_timer(0.8).timeout
	queue_free()

func disable_collision():
	$CollisionShape3D.disabled = true
