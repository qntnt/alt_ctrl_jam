class_name BaseSection
extends Area2D

# Right click me, and select "New Inherited Scene"

signal done()

func _on_body_exited(body: Node2D) -> void:
	if body is Robot:
		done.emit()