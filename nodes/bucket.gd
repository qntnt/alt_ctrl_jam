extends StaticBody2D

signal item_catch
signal item_lost


func _on_interior_body_entered(body: Node2D) -> void:
	item_catch.emit()

func _on_interior_body_exited(body: Node2D) -> void:
	item_lost.emit()
