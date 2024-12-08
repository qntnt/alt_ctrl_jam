extends BaseSection

@export var num_obstacles := 3

func _ready() -> void:
	var shape := collision_shape.shape as RectangleShape2D
	var start := collision_shape.global_position.x - (shape.size.x/2)
	var end := start + shape.size.x + 1
	var step := shape.size.x / (num_obstacles - 1)
	
	for x in range(start, end, step):
		var item := ItemDB.instantiate_random_item()
		NodeLocator.get_game_node().add_child.call_deferred(item)
		item.global_position = Vector2(x, 0)
		
		if(randf() > 0.75):
			var another := ItemDB.instantiate_random_item()
			NodeLocator.get_game_node().add_child.call_deferred(another)
			another.global_position = Vector2(x, 30)
