extends Node

signal left_hand_input_changed(value: float)
signal right_hand_input_changed(value: float)
signal button_pressed

const left_hand_keys := ['Q', 'W', 'E', 'R', 'T', 'Y', 'U']
const right_hand_keys := ['Z', 'X', 'C', 'V', 'B', 'N', 'M']

var left_hand_input := 0.0:
	set(value):
		if value == left_hand_input:
			return
		left_hand_input = value
		left_hand_input_changed.emit(value)

var right_hand_input := 0.0:
	set(value):
		if value == right_hand_input:
			return
		right_hand_input = value
		right_hand_input_changed.emit(value)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion:
		left_hand_input = Input.get_axis('left_hand_down', 'left_hand_up') * 3.0
		right_hand_input = Input.get_axis('right_hand_down', 'right_hand_up') * 3.0
	
	elif event is InputEventKey:
		var l := left_hand_keys.find(event.as_text_keycode())
		var r := right_hand_keys.find(event.as_text_keycode())
		if l >= 0:
			left_hand_input = l - 3
			left_hand_input_changed.emit(left_hand_input)
		elif r >= 0:
			right_hand_input = r - 3
			right_hand_input_changed.emit(right_hand_input)
		elif event.is_action_pressed("big_button"):
			button_pressed.emit()
