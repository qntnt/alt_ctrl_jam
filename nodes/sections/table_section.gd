extends BaseSection

@onready var shape := collision_shape.shape as RectangleShape2D
@onready var table := $Table as Table

func _ready() -> void:
	shape.size = table.shape.size
	collision_shape.position = table.collision_shape.position


func _on_body_exited(body: Node2D) -> void:
	if body is Robot:
		done.emit()
