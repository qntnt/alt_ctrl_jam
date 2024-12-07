extends CharacterBody2D

const left_hand_keys := ['Q', 'W', 'E', 'R', 'T', 'Y', 'U']
const right_hand_keys := ['Z', 'X', 'C', 'V', 'B', 'N', 'M']

var left_hand_input := 0
var right_hand_input := 0

@export var move_acceleration := 1000.0
@export var move_speed := 100.0

@onready var tray := $Tray as Tray
@onready var music_player := $MusicPlayer as AudioStreamPlayer
@onready var gravity: Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector") * ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta: float) -> void:
	tray.target_left_hand_value = left_hand_input
	tray.target_right_hand_value = right_hand_input
	
func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.RIGHT * move_speed + gravity, delta * move_acceleration)
	move_and_slide()
	music_player.pitch_scale = clampf(
		move_toward(music_player.pitch_scale, velocity.x / move_speed, delta),
		0.01,
		2.0
	)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		var l := left_hand_keys.find(event.as_text_keycode())
		if l >= 0:
			left_hand_input = l - 3
		if l == -1:
			var r := right_hand_keys.find(event.as_text_keycode())
			if r >= 0:
				right_hand_input = r - 3
