class_name Robot
extends CharacterBody2D

@export var move_acceleration := 1000.0
@export var move_speed := 100.0

@onready var tray := $Tray as Tray
@onready var music_player := $MusicPlayer as AudioStreamPlayer
@onready var gravity: Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector") * ProjectSettings.get_setting("physics/2d/default_gravity")
	
func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.RIGHT * move_speed + gravity, delta * move_acceleration)
	move_and_slide()
	music_player.pitch_scale = clampf(
		move_toward(music_player.pitch_scale, velocity.x / move_speed, delta),
		0.01,
		2.0
	)
	
