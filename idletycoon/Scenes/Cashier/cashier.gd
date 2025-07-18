extends Node2D
class_name Cashier

@export var move_speed := 50.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func move_to_customer() -> void:
	#Create tween to move
	animation_player.play("Move")

func move_to_item_position() -> void:
	# Create tween
	# Move
	# Start cook time
	animation_player.play("Idle")
