extends Node

var _items = {
	'cheese': preload("res://nodes/items/cheese.tscn"),
	'large_bowl': preload("res://nodes/items/large_bowl.tscn"),
	'small_plate': preload('res://nodes/items/small_plate.tscn'),
	'large_plate': preload('res://nodes/items/large_plate.tscn'),
	'mug': preload('res://nodes/items/mug.tscn'),
}

var audio_manager: AudioManager:
	get(): return NodeLocator.get_audio_manager()


func instantiate_item(id: String) -> RigidBody2D:
	var item = get_item_scene(id).instantiate() as RigidBody2D
	item.continuous_cd = RigidBody2D.CCD_MODE_CAST_RAY
	item.contact_monitor = true
	item.max_contacts_reported = 1
	item.can_sleep = false
	item.collision_layer = 0
	item.set_collision_layer_value(3, true)
	for i in range(1, 32):
		item.set_collision_mask_value(i, true)
	return item
	
func instantiate_random_item() -> RigidBody2D:
	return instantiate_item(_items.keys().pick_random())
	

func get_item_scene(id: String) -> PackedScene:
	return _items.get(id, null)

func get_random_item_scene() -> PackedScene:
	return _items.values().pick_random()
