extends Node2D
class_name Cashier

signal on_order_completed(cashier:Cashier)

@export var move_speed := 50.0
@onready var control: CookBar = $Control
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

func take_order() -> void:
	move_to_customer()
	await get_tree().create_timer(1.1).timeout
	current_customer.show_request()
	move_to_item_position()
	
func move_to_customer() -> void:
	var tween := create_tween()
	tween.tween_property(self, "position", counter_position, 1.0)
	animation_player.play("Move")

func move_to_item_position() -> void:
	animation_player.play("Move")
	var tween := create_tween()
	tween.tween_property(self, "position", item_counter_pos, 1.0)
	tween.tween_interval(0.3)
	tween.finished.connect(func(): start_cook_time())
	
func start_cook_time() -> void:
	animation_player.play("Idle")
	control.show()
	control.cook_item(item_request.cook_time)

func _on_control_on_cook_completed() -> void:
	control.hide()
	control.reset_bar()
	deliver_order()

func deliver_order() -> void:
	move_to_customer()
	await get_tree().create_timer(1.1).timeout
	current_customer.receive_order()
	GameManager.current_coins += item_request.profit
	GameManager.play_coin_vfx(global_position)
	
	if not current_customer.current_order_status <= 0:
		move_to_item_position()
	else:
		animation_player.play("Idle")
		current_customer = null 
		on_order_completed.emit(self)
