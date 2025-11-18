extends Node3D

@export var character: CharacterBody3D
@export var edge_spring_arm: SpringArm3D
@export var rear_spring_arm: SpringArm3D
@export var camera: Camera3D
@export var camera_align_speed: float = 0.2
@export var aim_rear_spring_length: float = 0.5
@export var aim_edge_spring_length: float = 0.5
@export var aim_speed: float = 0.2
@export var aim_fov: float = 55
@export var sprint_fov: float = 90
@export var sprint_speed: float = 0.5

#camera movement
var camera_rotation: Vector2 = Vector2.ZERO
var mouse_sensitivity: float = 0.001
var max_y_rotation: float = 1.1
#change camera side
var camera_tween: Tween

enum CameraAlignment {LEFT = -1, RIGHT = 1, CENTER = 0}
var current_camera_align: int = CameraAlignment.RIGHT

#maintains a default position
@onready var default_edge_spring_arm_length: float = edge_spring_arm.spring_length
@onready var default_rear_spring_arm_length: float = rear_spring_arm.spring_length
@onready var default_fov: float = camera.fov


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	#tracks mouse movement for camera
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#uses camera look to move camera in position with mouse
	if event is InputEventMouseMotion:
		var mouse_event: Vector2 = event.screen_relative * mouse_sensitivity
		camera_look(mouse_event)
	
	if event.is_action_pressed("swap_cam"):
		swap_cam()

#camera movement through mouse movement
func camera_look(mouse_movement: Vector2) -> void:
	camera_rotation += mouse_movement
	transform.basis = Basis()
	#change the green thingies to character if you want the old one
	$EdgeSpring/RearSpring/Camera3D.transform.basis = Basis()
	$EdgeSpring/RearSpring/Camera3D.rotate_object_local(Vector3(0, 1, 0), -camera_rotation.x)
	$EdgeSpring/RearSpring/Camera3D.rotate_object_local(Vector3(1, 0, 0), -camera_rotation.y)
	camera_rotation.y = clamp(camera_rotation.y, -max_y_rotation, max_y_rotation)
	
#cam swap
func swap_cam() -> void:
	match current_camera_align:
		CameraAlignment.RIGHT:
			set_camera_align(CameraAlignment.LEFT)
		CameraAlignment.LEFT:
			set_camera_align(CameraAlignment.RIGHT)
		CameraAlignment.CENTER:
			return
	
	var new_pos: float = default_edge_spring_arm_length * current_camera_align
	set_rear_spring_arm_pos(new_pos, camera_align_speed)
	
func set_camera_align(alignment: CameraAlignment) -> void:
	current_camera_align = alignment

func set_rear_spring_arm_pos(pos: float, speed: float) -> void:
	if camera_tween:
		camera_tween.kill()
	camera_tween = get_tree().create_tween()
	camera_tween.set_trans(Tween.TRANS_EXPO)
	camera_tween.set_ease(Tween.EASE_OUT)
	camera_tween.tween_property(edge_spring_arm, "spring_length", pos , speed)

func enter_aim() -> void:
	if camera_tween:
		camera_tween.kill()
	
	camera_tween = get_tree().create_tween()
	camera_tween.set_parallel()
	camera_tween.set_trans(Tween.TRANS_EXPO)
	camera_tween.set_ease(Tween.EASE_OUT)
	camera_tween.tween_property(camera, "fov", aim_fov, aim_speed)
	camera_tween.tween_property(edge_spring_arm, "spring_length", aim_edge_spring_length * current_camera_align, aim_speed)
	camera_tween.tween_property(rear_spring_arm, "spring_length", aim_rear_spring_length, aim_speed)
	
func exit_aim() -> void:
	if camera_tween:
		camera_tween.kill()
	
	camera_tween = get_tree().create_tween()
	camera_tween.set_parallel()
	camera_tween.set_trans(Tween.TRANS_EXPO)
	camera_tween.set_ease(Tween.EASE_OUT)
	camera_tween.tween_property(camera, "fov", default_fov, aim_speed)
	camera_tween.tween_property(edge_spring_arm, "spring_length", default_edge_spring_arm_length * current_camera_align, aim_speed)
	camera_tween.tween_property(rear_spring_arm, "spring_length", default_rear_spring_arm_length, aim_speed)
	
func enter_sprint() -> void:
	if camera_tween:
		camera_tween.kill()
	
	camera_tween = get_tree().create_tween()
	camera_tween.set_parallel()
	camera_tween.set_trans(Tween.TRANS_EXPO)
	camera_tween.set_ease(Tween.EASE_OUT)
	camera_tween.tween_property(camera, "fov", sprint_fov, sprint_speed)
	camera_tween.tween_property(edge_spring_arm, "spring_length", default_edge_spring_arm_length * current_camera_align, aim_speed)
	camera_tween.tween_property(rear_spring_arm, "spring_length", default_rear_spring_arm_length, aim_speed)

func exit_sprint() -> void:
	if camera_tween:
		camera_tween.kill()
	
	camera_tween = get_tree().create_tween()
	camera_tween.set_parallel()
	camera_tween.set_trans(Tween.TRANS_EXPO)
	camera_tween.set_ease(Tween.EASE_OUT)
	camera_tween.tween_property(camera, "fov", default_fov, sprint_speed)
	camera_tween.tween_property(edge_spring_arm, "spring_length", default_edge_spring_arm_length * current_camera_align, aim_speed)
	camera_tween.tween_property(rear_spring_arm, "spring_length", default_rear_spring_arm_length, aim_speed)


func _on_sprint_sprint_start() -> void:
	enter_sprint()

func _on_sprint_end() -> void:
	exit_sprint()

func _on_aim_enter() -> void:
	enter_aim()

func _on_aim_exit() -> void:
	exit_aim()
