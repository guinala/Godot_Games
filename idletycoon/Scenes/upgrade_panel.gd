extends Control
class_name UpgradePanel

@onready var label: Label = %Label
@onready var label_2: Label = %Label2
@onready var h_box_container: HBoxContainer = %HBoxContainer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var profit_text: Label = %ProfitText
@onready var preparacion_text: Label = %PreparacionText
@onready var button: Button = %Button


var item_ref : Item
var max_value : int
var current_value : int
var current_stars : int = -1 


func _process(delta: float) -> void:
	progress_bar.value = current_value / 25.0
	
func init_upgrade_panel(item: Item) -> void:
	item_ref = item
	item_ref.on_star_reached.connect(_on_star_reached)
	max_value = item.max_level
	progress_bar.value = 0
	update_stats()

func update_stats() -> void:
	label_2.text = item_ref.id
	label.text = "Lv. %s" % str(item_ref.current_level)
	profit_text.text = str(item_ref.profit)
	preparacion_text.text = str(item_ref.cook_time)
	button.text = str(item_ref.upgrade_cost)

func _on_star_reached() -> void:
	current_value = 0
	current_stars += 1
	var star: TextureRect = h_box_container.get_child(current_stars)
	star.modulate = Color(1,1,1)


func _on_button_pressed() -> void:
	SoundManager.play_ui()
	if GameManager.current_coins < item_ref.upgrade_cost:
		return
		
	GameManager.current_coins -= item_ref.upgrade_cost
	current_value += 1
	item_ref.update_item()
	update_stats()
