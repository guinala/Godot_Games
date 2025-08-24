extends Node2D
class_name Customer


@onready var body: Sprite2D = %Body
@onready var face: Sprite2D = %Face 
@onready var hand_left: Sprite2D = %HandLeft
@onready var hand_right: Sprite2D = %HandRight
@onready var item_box: Control = $ItemBox
@onready var icon: TextureRect = %Icon
@onready var label: Label = %Label

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var request_item: Item
var request_quantity: int
var current_order_status: int

var counter_pos: Vector2
var being_served : bool
var waiting_order : bool

func _process(delta: float) -> void:
	label.text = str(current_order_status)
	
func init_customer(item: Item, quantity: int) -> void:
	request_item = item
	request_quantity = quantity
	current_order_status = quantity
	
func move_to_counter() -> void:
	play_move_anim()
	var counter_top_pos := Vector2(counter_pos.x, position.y)
	var tween := create_tween()
	tween.tween_property(self, "position", counter_top_pos, 1.0)
	tween.tween_interval(0.2)
	tween.tween_property(self, "position", counter_pos, 1.0)
	tween.tween_interval(0.5)
	tween.finished.connect(func(): tweenFinished())

func tweenFinished() -> void:
	animation_player.play("Idle")
	waiting_order = true
	GameManager.on_customer_request.emit(self)
	
func set_sprites(data: CustomerData) -> void:
	body.texture = data.body
	face.texture = data.face
	hand_left.texture = data.hands
	hand_right.texture = data.hands

func play_move_anim() -> void:
	animation_player.play("Move")

func receive_order() -> void:
	current_order_status -= 1
	if current_order_status <= 0:
		order_completed()

func order_completed() -> void:
	item_box.hide()
	waiting_order = false
	var counter_top_pos = counter_pos.y - 180
	var tween := create_tween()
	tween.tween_property(self, "position", Vector2(counter_pos.x, counter_top_pos), 1.0)
	tween.tween_interval(0.2)
	tween.tween_property(self, "position", Vector2(counter_pos.x + 800, counter_top_pos), 3.0)
	tween.tween_interval(0.2)
	tween.finished.connect(
		func():
			animation_player.play("Idle")
			waiting_order = true
			GameManager.on_customer_request.emit(self)
	)
func show_request() -> void:
	item_box.show()
	icon.texture = request_item.sprite
	label.text = str(request_quantity)
