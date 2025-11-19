extends Node3D

@onready var a_tree = $AnimationTree

var current_aim_state : float = 0.0

func _ready():
	top_level = true

func set_walk_direction(dir : Vector2):
	a_tree.set("parameters/WalkDirection/blend_position", dir)

func set_aim_state(state : float):
	var tween = create_tween()
	tween.tween_property(self, "current_aim_state", state, 0.1)

func activate_shoot():
	a_tree.set("parameters/Shoot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)

func get_root_pos():
	return a_tree.get_root_motion_position()

func _process(delta):
	global_position = get_parent().global_position
	global_rotation.y = get_parent().global_rotation.y + PI

func _physics_process(delta):
	a_tree.set("parameters/TorsoState/blend_position", current_aim_state)
	a_tree.set("parameters/AimState/blend_position", current_aim_state)
	

func _on_sprint_sprint_end():
	a_tree.set("parameters/TimeScale/scale", 1.5)

func _on_sprint_sprint_start():
	a_tree.set("parameters/TimeScale/scale", 2.1)

func _on_aim_enter():
	a_tree.set("parameters/TimeScale/scale", 0.7)

func _on_aim_exit():
	a_tree.set("parameters/TimeScale/scale", 1.5)
