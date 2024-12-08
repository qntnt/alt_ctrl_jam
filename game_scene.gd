class_name Game
extends Node2D

var score := 0:
	set(v):
		score = v
		if score_display:
			score_display.text = str(score)

@onready var score_display := $CanvasLayer/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Score as Label
