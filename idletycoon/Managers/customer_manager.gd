extends Node
class_name CustomerManager

@export var spawn_positions: Array[Marker2D]
@export var customer_sprites: Array[CustomerData]
@export var customer_scene: PackedScene
@onready var counter_manager: CounterManager = %CounterManager

func _ready() -> void:
	spawn_customer()

func spawn_customer() -> void:
	var customer: Customer = customer_scene.instantiate()
	add_child(customer)
	
	# Get random sprites
	var sprite_data: CustomerData = customer_sprites.pick_random()
	customer.set_sprites(sprite_data)
	
	var random_item : Item = GameManager.get_random_item()
	var quantity: int = randi_range(1,3)
	customer.init_customer(random_item, quantity)
	
	if counter_manager.get_free_index() != -1:
		customer.position = spawn_positions[1].position
		counter_manager.assign_customer(customer)
		customer.move_to_counter()
	else:
		var randomStartPos : Marker2D = spawn_positions.pick_random()
		customer.global_position = randomStartPos.position
		customer.play_move_anim()
		var tween := create_tween()
		tween.tween_property(customer, "position", customer.position + Vector2.RIGHT*1300, 4.5)
		tween.finished.connect(func(): customer.queue_free())

func _on_timer_timeout() -> void:
	spawn_customer()
