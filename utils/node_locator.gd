extends Node

var _game_node: Game
var _audio_manager: AudioManager

func get_game_node() -> Game:
	if _game_node:
		return _game_node
	var group_nodes = get_tree().get_nodes_in_group('root')
	if !group_nodes.is_empty():
		_game_node = group_nodes[0]
	return _game_node as Game

func get_audio_manager() -> AudioManager:
	if _audio_manager:
		return _audio_manager
	var game = get_game_node()
	if game:
		_audio_manager = game.audio_manager
	return _audio_manager
