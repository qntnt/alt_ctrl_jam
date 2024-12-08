class_name Robot
extends CharacterBody2D

const sections := {
	0: preload('res://nodes/sections/table_section.tscn'),
	1: preload('res://nodes/sections/bucket_section.tscn'),
}

const section_transitions := {
	0: [1],
	1: [0],
}

@export var move_acceleration := 1000.0
@export var move_speed := 100.0

@onready var tray := $Tray as Tray
@onready var music_player := $MusicPlayer as AudioStreamPlayer
@onready var gravity: Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector") * ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player := $Body/AnimationPlayer as AnimationPlayer
@onready var next_section_spawn_point := $NextSectionSpawnPoint as Node2D

var _next_section_id := 0

func _ready() -> void:
	_spawn_next_section()

func _spawn_next_section() -> void:
	var section = sections[_next_section_id].instantiate() as BaseSection
	NodeLocator.get_game_node().add_child.call_deferred(section)
	section.global_position = next_section_spawn_point.global_position
	_next_section_id = section_transitions[_next_section_id].pick_random()
	section.done.connect(_on_section_done)

func _on_section_done() -> void:
	_spawn_next_section()

func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.RIGHT * move_speed + gravity, delta * move_acceleration)
	move_and_slide()
	_update_animation()
	_update_audio(delta)
	_forward_collisions()

func _forward_collisions() -> void:
	for collision_id in get_slide_collision_count():
		var collision = get_slide_collision(collision_id)
		var collider = collision.get_collider()
		if collider.has_method('robot_collision'):
			collider.robot_collision(self)

func _update_audio(delta: float) -> void:
	music_player.pitch_scale = clampf(
		move_toward(music_player.pitch_scale, velocity.x / move_speed, delta),
		0.01,
		2.0
	)
	
func _update_animation() -> void:
	if get_real_velocity().length() > 10:
		animation_player.play('walk')
	else:
		animation_player.play('idle')
