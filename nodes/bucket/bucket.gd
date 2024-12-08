extends StaticBody2D

signal item_catch(item: Node2D)
signal item_lost(item: Node2D)

var counting_down := false
var count := 5
var items: Array[Node2D] = []

@onready var countdown_label := $CountdownLabel as Label

func _on_interior_body_entered(body: Node2D) -> void:
	item_catch.emit(body)

func _on_interior_body_exited(body: Node2D) -> void:
	item_lost.emit(body)

# Implicit method for robot to forward collision
func robot_collision(robot: Robot) -> void:
	_start_countdown()

func _start_countdown() -> void:
	if counting_down:
		return
	counting_down = true
	await _tick()
	
func _tick() -> void:
	if count <= 1:
		queue_free()
	countdown_label.text = str(count)
	await get_tree().create_timer(1.0).timeout
	count -= 1
	await _tick()
