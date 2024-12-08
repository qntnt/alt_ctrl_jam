class_name BucketSection
extends BaseSection

@onready var game := NodeLocator.get_game_node()

func _on_bucket_item_catch(item: Node2D) -> void:
	game.score += 1

func _on_bucket_item_lost(item: Node2D) -> void:
	game.score -= 1
