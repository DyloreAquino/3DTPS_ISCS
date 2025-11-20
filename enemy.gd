extends Node3D

@export var speed = 2
@onready var character = $CharacterBody3D
@onready var nav_agent = $CharacterBody3D/NavigationAgent3D
@onready var animation_player = $CharacterBody3D/Mesh/AnimationPlayer

var can_move = true

func _physics_process(delta):
	if can_move:
		var current_location = character.global_position
		var next_location = nav_agent.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized() * speed
		
		character.velocity = new_velocity
		if next_location != current_location:
			character.look_at(next_location)
		character.velocity.y = -9.8
		
		character.move_and_slide()
		
		if character.velocity:
			animation_player.play("run_ani_vor")
		else:
			animation_player.play("normal")
		

func update_target_location(target_location):
	nav_agent.set_target_position(target_location)

func die():
	can_move = false
	animation_player.play("die")
	
	await animation_player.animation_finished
	
	queue_free()
