class_name Robot
extends CharacterBody2D

const sections := {
	0: preload('res://nodes/sections/table_section.tscn'),
	1: preload('res://nodes/sections/obstacle_section.tscn'),
	2: preload('res://nodes/sections/bucket_section.tscn'),
}

const section_transitions := {
	0: [1],
	1: [2],
	2: [0],
}

@export var move_acceleration := 1000.0
@export var move_speed := 100.0
@export var distance_between_sections := 150

@onready var tray := $Tray as Tray
@onready var music_player := $MusicPlayer as AudioStreamPlayer
@onready var gravity: Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector") * ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player := $Body/AnimationPlayer as AnimationPlayer
@onready var next_section_spawn_point := $NextSectionSpawnPoint as Node2D
@onready var game := NodeLocator.get_game_node()

var _current_section: BaseSection
var _next_section: BaseSection
var _next_section_id := 0

var frozen := true

func _ready() -> void:
	_spawn_next_section()
	await get_tree().process_frame
	_spawn_next_section()

func _spawn_next_section() -> void:
	if !game:
		return
	var section = sections[_next_section_id].instantiate() as BaseSection
	NodeLocator.get_game_node().add_child.call_deferred(section)
	if _current_section:
		var section_shape = _current_section.collision_shape.shape as RectangleShape2D
		section.global_position.x = _current_section.global_position.x + section_shape.size.x + distance_between_sections
		_next_section = section
	else:
		section.global_position.x = next_section_spawn_point.global_position.x
		_current_section = section
		
	_next_section_id = section_transitions[_next_section_id].pick_random()
	section.done.connect(_on_section_done)

func _on_section_done() -> void:
	if(_next_section):
		_current_section = _next_section
		_next_section = null
	_spawn_next_section()

func _physics_process(delta: float) -> void:
	if frozen:
		velocity = Vector2.ZERO
	else:
		var forward := Vector2.RIGHT * move_speed
		if get_parent().score > 10:
			forward *= get_parent().score / 10
		velocity = velocity.move_toward(forward + gravity, delta * move_acceleration)
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
	game.audio_manager.update_from_robot(self, delta)
	
func _update_animation() -> void:
	if get_real_velocity().length() > 10:
		animation_player.play('walk')
	else:
		animation_player.play('idle')


func _on_input_controller_button_pressed() -> void:
	frozen = false
