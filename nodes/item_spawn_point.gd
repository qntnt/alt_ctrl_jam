extends Area2D

@export var item_to_spawn: PackedScene

@onready var spawn_target := $SpawnTarget as Node2D
@onready var animation_player := $Sprite/AnimationPlayer as AnimationPlayer

func _ready() -> void:
	animation_player.play('idle')

func spawn_item() -> void:
	var item := ItemDB.instantiate_random_item()
	add_child.call_deferred(item)
	item.global_position = spawn_target.global_position
	animation_player.play('active')
	await get_tree().create_timer(0.5).timeout
	animation_player.play('idle')

func _on_body_entered(body: Node2D) -> void:
	if item_to_spawn == null || !(body is Robot):
		return
	spawn_item()
	
