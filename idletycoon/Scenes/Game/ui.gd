extends CanvasLayer
class_name UI

@export var cashier_1_cost := 50
@export var cashier_2_cost := 500
@export var cashier_3_cost := 5000
@export var faster_coffee_cost := 250
@export var faster_burger_cost := 1000

@onready var coffee_upgrade_panel: UpgradePanel = $CoffeeUpgradePanel
@onready var burger_upgrade_panel_2: UpgradePanel = $BurgerUpgradePanel2
@onready var current_coins: Label = %CurrentCoins
@onready var new_cashier: Panel = %NewCashier
@onready var new_cashier_button: Button = %NewCashierButton
@onready var faster_coffee: Panel = %FasterCoffee
@onready var faster_coffee_button: Button = %FasterCoffeeButton
@onready var faster_burger: Panel = %FasterBurger
@onready var faster_burger_button: Button = %FasterBurgerButton
@onready var new_cashier_2: Panel = %NewCashier2
@onready var new_cashier_button_2: Button = %NewCashierButton2
@onready var new_cashier_3: Panel = %NewCashier3
@onready var new_cashier_butto_3: Button = %NewCashierButto3


func _ready() -> void:
	coffee_upgrade_panel.init_upgrade_panel(GameManager.coffee)
	burger_upgrade_panel_2.init_upgrade_panel(GameManager.burger)
	
	new_cashier_button.text = str(cashier_1_cost)
	new_cashier_button_2.text = str(cashier_2_cost)
	new_cashier_butto_3.text = str(cashier_3_cost)
	faster_burger_button.text = str(faster_burger_cost)
	faster_coffee_button.text = str(faster_coffee_cost)
	
func _process(delta: float) -> void:
	current_coins.text = str(GameManager.current_coins)

func _on_coffee_button_pressed() -> void:
	SoundManager.play_ui()
	burger_upgrade_panel_2.hide()
	coffee_upgrade_panel.visible = true if not coffee_upgrade_panel.visible else false
	

func _on_burger_button_pressed() -> void:
	SoundManager.play_ui()
	coffee_upgrade_panel.hide()
	burger_upgrade_panel_2.visible = true if not burger_upgrade_panel_2.visible else false


func _on_new_cashier_butto_3_pressed() -> void:
	pass # Replace with function body.


func _on_new_cashier_button_2_pressed() -> void:
	pass # Replace with function body.


func _on_faster_burger_button_pressed() -> void:
	pass # Replace with function body.


func _on_faster_coffee_button_pressed() -> void:
	pass # Replace with function body.


func _on_new_cashier_button_pressed() -> void:
	pass # Replace with function body.
