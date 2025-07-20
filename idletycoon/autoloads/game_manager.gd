extends Node

signal on_customer_request(customer: Customer)

@export var coffee : Item
@export var burger : Item

var coffee_counter_pos := Vector2
var burger_counter_pos := Vector2

func get_random_item() -> Item:
	var items: Array = [coffee,burger]
	return items.pick_random()
	
func get_item_pos(item:Item) -> Vector2:
	match item.type:
		Item.ItemType.Coffee:
			return
