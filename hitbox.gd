extends Area3D

var health = 100
@onready var enemy = $"../.."
var ex = preload("res://World/explosion.tscn")

func _process(delta):
	$SubViewport/ProgressBar.value = health

func _on_body_entered(body):
	if body is Bullet:
		destroy_bullet(body)
		health -= 25
		if health <= 0:
			enemy.die()
			call_deferred("disable_collision")


func destroy_bullet(bullet):
	var plosion = ex.instantiate()
	get_tree().current_scene.add_child(plosion)
	plosion.global_position = bullet.global_position
	plosion.emit_explosion(true)
	bullet.play_audios()

func disable_collision():
	$CollisionShape3D.disabled = true
