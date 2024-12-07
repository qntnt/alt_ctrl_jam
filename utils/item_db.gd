extends Node

var _items = {
	'cheese': preload("res://nodes/cheese.tscn"),
	'large_bowl': preload("res://nodes/large_bowl.tscn"),
	'small_plate': preload('res://nodes/small_plate.tscn'),
	'large_plate': preload('res://nodes/large_plate.tscn'),
	'mug': preload('res://nodes/mug.tscn'),
}

func get_item_scene(id: String) -> PackedScene:
	return _items.get(id, null)

func get_random_item_scene() -> PackedScene:
	return _items.values().pick_random()
