extends Node2D
class_name Cashier

@export var move_speed := 50.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_customer : Customer
var counter_position : Vector2
var item_counter_pos : Vector2
var item_request : Item

func set_customer(customer:Customer)->void:
	current_customer = customer
	customer.being_served = true
	item_request = customer.request_item
	counter_position = Vector2(customer.position.x, customer.position.y + 160)
	item_counter_pos = GameManager.get_item_pos(item_request)

func taker_order() -> void:
	move_to_customer()
	await get_tree().create_timer(1.1).timeout
	current_customer.show_request()
	move_to_item_position()
	
func move_to_customer() -> void:
	var tween := create_tween()
	tween.tween_property(self, "position", counter_position, 1.0)
	animation_player.play("Move")

func move_to_item_position() -> void:
	# Create tween
	# Move
	# Start cook time
	animation_player.play("Idle")
