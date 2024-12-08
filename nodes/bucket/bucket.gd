extends StaticBody2D

signal item_catch(item: Node2D)
signal item_lost(item: Node2D)

var counting_down := false
var count := 5
var items: Dictionary = {}
var destroying := false

@onready var interior_area := $interior as Area2D
@onready var countdown_label := $CountdownLabel as Label

func _on_interior_body_entered(body: Node2D) -> void:
	if destroying:
		return
	items[body.get_instance_id()] = body
	item_catch.emit(body)

func _on_interior_body_exited(body: Node2D) -> void:
	if destroying:
		return
	items.erase(body.get_instance_id())
	item_lost.emit(body)

# Implicit method for robot to forward collision
func robot_collision(robot: Robot) -> void:
	if destroying:
		return
	_start_countdown()

func _start_countdown() -> void:
	if destroying:
		return
	if counting_down:
		return
	counting_down = true
	await _tick()
	
func _tick() -> void:
	if destroying:
		return
	if count < 1:
		destroy()
	else:
		countdown_label.text = str(count)
		await get_tree().create_timer(1.0).timeout
		count -= 1
		await _tick()

func destroy() -> void:
	destroying = true
	for item in items.values():
		item.queue_free()
	queue_free()
