extends BaseSection

@export var num_obstacles := 3

@onready var collision_shape := $CollisionShape2D as CollisionShape2D
@onready var shape := collision_shape.shape as RectangleShape2D

func _ready() -> void:
	var start := collision_shape.global_position.x - (shape.size.x/2)
	var end := start + shape.size.x + 1
	var step := shape.size.x / (num_obstacles - 1)
	
	for x in range(start, end, step):
		var item := ItemDB.instantiate_random_item()
		NodeLocator.get_game_node().add_child.call_deferred(item)
		item.global_position = Vector2(x, 0)

#func _on_body_exited(body: Node2D) -> void:
	#if body is Robot:
		#done.emit()
