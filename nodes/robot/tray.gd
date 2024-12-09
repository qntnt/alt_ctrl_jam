class_name Tray
extends CharacterBody2D

const TRAY_Y := -72

var _target_left_hand_position := Vector2(-24, TRAY_Y)
var _target_right_hand_position := Vector2(24, TRAY_Y)
var _target_tray_position := Vector2(0, TRAY_Y)

@export var tray_movement_speed := 100
@export var hand_movement_range := 4
@export var rotation_speed := 4

@onready var audio_player := $AudioStreamPlayer2D as AudioStreamPlayer2D

func _physics_process(delta: float) -> void:
	_target_tray_position.y = (_target_left_hand_position.y + _target_right_hand_position.y) / 2.0
	rotation = move_toward(rotation, _hand_rotation(), rotation_speed * delta)
	position = position.move_toward(_target_tray_position, tray_movement_speed * delta)
	
func _hand_rotation() -> float:
	return _target_left_hand_position.angle_to_point(_target_right_hand_position)

func _on_input_controller_left_hand_input_changed(value: int) -> void:
	_target_left_hand_position.y = TRAY_Y + -value * hand_movement_range

func _on_input_controller_right_hand_input_changed(value: int) -> void:
	_target_right_hand_position.y = TRAY_Y + -value * hand_movement_range
