extends Node2D

var score := int(0)
@onready var score_display := $ScoreDisplay as Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_bucket_item_catch() -> void:
	score += 1
	score_display.text = str(score)

func _on_bucket_item_lost() -> void:
	score -= 1
	score_display.text = str(score)
