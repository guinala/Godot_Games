extends Area2D
class_name WeaponPickup

var can_interact : bool

@export var weapon_data : WeaponData

@onready var price: Label = %Price
@onready var buy: Label = $Buy
@onready var werapon_sprite: Sprite2D = $WeraponSprite

func _ready() -> void:
	set_weapon()

func set_weapon() -> void:
	werapon_sprite.texture = weapon_data.weapon_sprite
	werapon_sprite.modulate = weapon_data.weapon_color
	price.text = str(weapon_data.buy_price)

func _input(event: InputEvent) -> void:
	if can_interact and event.is_action_pressed("Interact"):
		if GameManager.coins >= weapon_data.buy_price:
			GameManager.remove_coins(weapon_data.buy_price)
			GameManager.player.setup_weapon(weapon_data)

func _on_body_entered(body: Node2D) -> void:
	buy.show() 
	print("si")
	can_interact = true


func _on_body_exited(body: Node2D) -> void:
	buy.hide()
	can_interact = false
