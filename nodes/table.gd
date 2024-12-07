extends Node2D

var diner_scene: PackedScene = preload("res://nodes/diner.tscn")

@export var min_diners := 1
@export var max_diners := 10
@export var size_distribution := Curve.new()
@export var x_separation := 48

@onready var diner_count := _rand_size()
@onready var nine_patch_rect := $NinePatchRect as NinePatchRect

func _ready() -> void:
	var x_offset = nine_patch_rect.size.x / 2
	nine_patch_rect.size.x = nine_patch_rect.size.x + (diner_count * (x_separation * 2))
	for i in diner_count:
		var diner = diner_scene.instantiate() as Node2D
		add_child(diner)
		diner.position.x = x_offset
		x_offset += x_separation * 2

func _rand_size() -> int:
	var s := size_distribution.sample(randf())
	var size_range = max_diners - min_diners
	return roundi(s * size_range + min_diners)
	
