extends Node3D

@onready var a_tree = $AnimationTree

func set_walk_direction(dir : Vector2):
	a_tree.set("parameters/WalkDirection/blend_position", dir)

func set_aim_state(state : int):
	a_tree.set("parameters/TorsoState/blend_position", state)
	a_tree.set("parameters/AimState/blend_position", state)

func activate_shoot():
	a_tree.set("parameters/Shoot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func get_root_pos():
	return a_tree.get_root_motion_position()
