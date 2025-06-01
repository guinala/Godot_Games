extends Node2D
class_name Ground

signal on_player_crash

@export var speed := -150.0
@onready var ground_1: Area2D = $Ground1
@onready var ground_2: Area2D = $Ground2
@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var width : float

func _ready() -> void:
	width = sprite_2d.texture.get_width()

func _process(delta: float) -> void:
	ground_1.global_position.x += speed * delta
	ground_2.global_position.x += speed * delta
	
	if ground_1.global_position.x < -width / 2:
		ground_1.global_position.x = ground_2.global_position.x + width
	
	if ground_2.global_position.x < -width / 2:
		ground_2.global_position.x = ground_1.global_position.x + width


func _on_ground_body_entered(body: Node2D) -> void:
	on_player_crash.emit()
	speed = 0
	var player := body as Player
	player.stop_movement()
	player.stop_gravity()
	audio_stream_player.play()
