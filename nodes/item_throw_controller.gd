extends Node2D

@export var shoot_target:Node2D
@export var shoot_speed:float = 1000.0

@onready var spawn_point := $SpawnPoint as Node2D
@onready var cheese_scene:PackedScene = preload("res://nodes/cheese.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_input_controller_button_pressed() -> void:
	var item := cheese_scene.instantiate() as RigidBody2D
	item.top_level = true
	item.position = spawn_point.global_position
	item.linear_velocity = shoot_speed * item.global_position.direction_to(shoot_target.global_position)
	add_child(item)
