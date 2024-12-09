class_name AudioManager
extends Node2D

@onready var music_player := $MusicPlayer as AudioStreamPlayer
@onready var tap_player := $TapPlayer as AudioStreamPlayer2D

@onready var _master_bus_id := AudioServer.get_bus_index("Master")
@onready var _music_bus_id := AudioServer.get_bus_index("Music")
@onready var _sfx_bus_id := AudioServer.get_bus_index("SFX")

@onready var _music_low_pass := AudioServer.get_bus_effect(_music_bus_id, 0) as AudioEffectLowPassFilter
@onready var _music_reverb := AudioServer.get_bus_effect(_music_bus_id, 1) as AudioEffectReverb
@onready var _music_pitch_shift := AudioServer.get_bus_effect(_music_bus_id, 2) as AudioEffectPitchShift

var _should_play_tap := false

func _process(delta: float) -> void:
	if _should_play_tap == true:
		tap_player.play()

func play_tap() -> void:
	_should_play_tap = true

func update_from_robot(robot: Robot, delta: float) -> void:
	music_player.pitch_scale = clampf(
		move_toward(music_player.pitch_scale, robot.get_real_velocity().length() / robot.move_speed, delta / 4.0),
		0.7937,
		1.3
	)
