extends Area2D

@export var item_to_spawn: PackedScene
@export var shoot_target: Node2D

@onready var spawn_target := $SpawnTarget as Node2D


func _on_body_entered(body: Node2D) -> void:
	print(body)
	if item_to_spawn == null || body == self:
		return
	var item := item_to_spawn.instantiate() as RigidBody2D
	add_child(item)
	item.top_level = true
	item.global_position = spawn_target.global_position
	
