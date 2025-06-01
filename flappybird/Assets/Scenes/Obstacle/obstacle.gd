extends Node2D
class_name Obstacle

signal on_player_crashed
signal on_player_scored

@export var move_speed := 150.0

@onready var hit: AudioStreamPlayer = $Hit
@onready var score_2: AudioStreamPlayer = $Score2

func _process(delta: float) -> void:
	position.x -= move_speed * delta

func on_area_entered(body: Node2D) -> void:
	on_player_crashed.emit()
	hit.play()

func set_speed(value:float) -> void:
	move_speed = value

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_score_body_entered(body: Node2D) -> void:
	on_player_scored.emit()
	score_2.play()
