class_name Tray
extends CharacterBody2D

const TRAY_Y := -40

var _target_left_hand_position := Vector2(-24, TRAY_Y)
var _target_right_hand_position := Vector2(24, TRAY_Y)
var _target_tray_position := Vector2(0, TRAY_Y)

@export var tray_movement_speed := 100
@export var hand_movement_range := 4
@export var rotation_speed := 4
@export_range(-3, 3) var target_left_hand_value := 0
@export_range(-3, 3) var target_right_hand_value := 0

func _physics_process(delta: float) -> void:
	_target_left_hand_position.y = TRAY_Y + -target_left_hand_value * hand_movement_range
	_target_right_hand_position.y = TRAY_Y + -target_right_hand_value * hand_movement_range
	_target_tray_position.y = (_target_left_hand_position.y + _target_right_hand_position.y) / 2.0
	rotation = move_toward(rotation, _hand_rotation(), rotation_speed * delta)
	position = position.move_toward(_target_tray_position, tray_movement_speed * delta)
	
func _hand_rotation() -> float:
	return _target_left_hand_position.angle_to_point(_target_right_hand_position)
