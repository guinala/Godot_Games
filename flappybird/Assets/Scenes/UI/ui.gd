extends CanvasLayer
class_name UI

const MEDAL_BRONZE = preload("res://Assets/Sprites/UI/medalBronze.png")
const MEDAL_GOLD = preload("res://Assets/Sprites/UI/medalGold.png")
const MEDAL_SILVER = preload("res://Assets/Sprites/UI/medalSilver.png")

@onready var medalTexture: TextureRect = %TextureRect
@onready var current_score: Label = %CurrentScore
@onready var best_score: Label = %BestScore

@onready var score_label: Label = %ScoreLabel
@onready var start_menu: Control = %StartMenu
@onready var game_over_menu: VBoxContainer = %GameOverMenu

func _ready() -> void:
	score_label.text = "0"

func update_score(value: int) -> void:
	score_label.text = str(value)

func game_over() -> void:
	game_over_menu.show()
	score_label.hide()

func calculate_score(score : int, high : int) -> void:
	current_score.text = str(score)
	best_score.text = str(high)
	if score >= 20:
		medalTexture.texture = MEDAL_GOLD
	elif score >= 10:
		medalTexture.texture = MEDAL_SILVER
	else:
		medalTexture.texture = MEDAL_BRONZE

func _on_play_pressed() -> void:
	get_tree().reload_current_scene()
