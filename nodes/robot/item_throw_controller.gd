extends Node2D

@export var shoot_target:Node2D
@export var shoot_speed:float = 1000.0

@onready var spawn_point := $SpawnPoint as Node2D
@onready var cheese_scene:PackedScene = preload("res://nodes/items/cheese.tscn")


func _on_input_controller_button_pressed() -> void:
	var item := ItemDB.instantiate_item('cheese')
	item.position = spawn_point.global_position
	item.linear_velocity = shoot_speed * item.global_position.direction_to(shoot_target.global_position)
	NodeLocator.get_game_node().add_child(item)
