extends Node

@onready var _game_node: Node2D

func get_game_node() -> Node2D:
	if _game_node == null:
		_game_node = get_tree().get_nodes_in_group('root')[0]
	return _game_node

func _find_game_node() -> Node2D:
	return get_tree().get_nodes_in_group('root')[0]
