extends StaticBody2D

signal item_catch
signal item_lost

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interior_body_entered(body: Node2D) -> void:
	item_catch.emit()

func _on_interior_body_exited(body: Node2D) -> void:
	item_lost.emit()
