class_name Game
extends Node2D

var score := int(0)
@onready var score_display := $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Score as Label

func _on_bucket_item_catch() -> void:
	score += 1
	score_display.text = str(score)

func _on_bucket_item_lost() -> void:
	score -= 1
	score_display.text = str(score)
 
