extends Area2D

const head_back_textures: Array[Texture2D] = [
	preload('res://sprites/diners/head_back_1.png'),
	preload('res://sprites/diners/head_back_2.png'),
	preload('res://sprites/diners/head_back_3.png'),
]
const head_front_textures: Array[Texture2D] = [
	preload('res://sprites/diners/head_front_1.png'),
	preload('res://sprites/diners/head_front_2.png'),
	preload('res://sprites/diners/head_front_3.png'),
]
const face_textures: Array[Texture2D] = [
	preload('res://sprites/diners/face_1.png'),
	preload('res://sprites/diners/face_2.png'),
]
const torso_textures: Array[Texture2D] = [
	preload("res://sprites/diners/torso_1.png"),
	preload("res://sprites/diners/torso_2.png"),
	preload("res://sprites/diners/torso_3.png"),
]
const legs_textures: Array[Texture2D] = [
	preload("res://sprites/diners/legs_1.png"),
	preload("res://sprites/diners/legs_2.png"),
]

@export var item_to_spawn: PackedScene

@onready var spawn_target := $SpawnTarget as Node2D
@onready var hand_sprite := $SpawnTarget/Hand as Sprite2D
@onready var head_back_sprite := $BodySprites/HeadBack as Sprite2D
@onready var head_front_sprite := $BodySprites/HeadFront as Sprite2D
@onready var face_sprite := $BodySprites/Face as Sprite2D
@onready var torso_sprite := $BodySprites/Torso as Sprite2D
@onready var legs_sprite := $BodySprites/Legs as Sprite2D

@onready var head_variant := randi_range(0, head_back_textures.size() - 1)
@onready var face_variant := randi_range(0, face_textures.size() - 1)
@onready var torso_variant := randi_range(0, torso_textures.size() - 1)
@onready var legs_variant := randi_range(0, legs_textures.size() - 1)

@onready var skin_tone := random_color()

func _ready() -> void:
	face_sprite.texture = face_textures[face_variant]
	
	head_back_sprite.texture = head_back_textures[head_variant]
	head_back_sprite.modulate = skin_tone

	head_front_sprite.texture = head_front_textures[head_variant]
	head_front_sprite.modulate = skin_tone
	
	hand_sprite.modulate = skin_tone
	
	torso_sprite.texture = torso_textures[torso_variant]
	torso_sprite.modulate = random_color()
	
	legs_sprite.texture = legs_textures[legs_variant]
	legs_sprite.modulate = random_color()

func spawn_item() -> void:
	var item := ItemDB.instantiate_random_item()
	NodeLocator.get_game_node().add_child(item)
	item.global_position = spawn_target.global_position
	start_active_animation()

func start_active_animation() -> void:
	head_back_sprite.visible = false
	head_front_sprite.visible = true
	face_sprite.visible = true
	hand_sprite.visible = true
	await get_tree().create_timer(0.5).timeout
	head_back_sprite.visible = true
	head_front_sprite.visible = false
	face_sprite.visible = false
	hand_sprite.visible = false

func random_color(blend: Color = Color.WHITE, amount: float = 0.75) -> Color:
	return Color(
		randi_range(0.0, 1.0),
		randi_range(0.0, 1.0),
		randi_range(0.0, 1.0),
	).lerp(blend, amount)

func _on_body_entered(body: Node2D) -> void:
	if item_to_spawn == null || !(body is Robot):
		return
	spawn_item()
	
