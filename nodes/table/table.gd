class_name Table
extends Node2D

var diner_scene: PackedScene = preload("res://nodes/table/diner.tscn")

@export var min_diners := 4
@export var max_diners := 15
@export var size_distribution := Curve.new()
@export var x_separation := 48

@onready var diner_count := _rand_size()
@onready var nine_patch_rect := $NinePatchRect as NinePatchRect
@onready var collision_shape := $CollisionShape2D as CollisionShape2D
@onready var shape := collision_shape.shape as RectangleShape2D

func _ready() -> void:
	nine_patch_rect.size.x = nine_patch_rect.size.x + (diner_count * (x_separation * 2))
	shape.size.x = nine_patch_rect.size.x
	collision_shape.position.x = shape.size.x / 2
	nine_patch_rect.position.x = collision_shape.position.x - shape.size.x / 2
	
	var x_offset = 48 + 32
	for i in diner_count:
		var diner = diner_scene.instantiate() as Node2D
		add_child(diner)
		diner.position.x = x_offset
		x_offset += x_separation * 2

func _rand_size() -> int:
	var s := size_distribution.sample(randf())
	var size_range = max_diners - min_diners
	return roundi(s * size_range + min_diners)
	
