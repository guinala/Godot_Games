extends Node2D
class_name Game

@onready var player: Player = $Player
@onready var spawn: Marker2D = $Spawn
@onready var spawn_checkpoint: Marker2D = $SpawnCheckpoint
@onready var game_won: Panel = $UI/GameWon
@onready var label_fruits: Label = $UI/Control/Label

var points: int
var checkpoint_reached: bool

func _ready() -> void:
	EventManager.on_player_dead.connect(_on_player_dead)
	EventManager.on_fruit_collected.connect(_on_fruit_collected)
	EventManager.on_checkpoint_reached.connect(_on_checkpoint_reached)
	EventManager.on_game_won.connect(_on_game_won)
	
func _process(delta: float) -> void:
	label_fruits.text = str(points)
	
func _on_player_dead() -> void:
	player.player_dead()
	await get_tree().create_timer(0.5).timeout
	var tween := create_tween()
	tween.tween_property(player, "global_position", get_respawn_pos(), 0.5)
	tween.tween_callback(player.player_respawn)

func _on_fruit_collected() -> void:
	points += 1

func _on_checkpoint_reached() -> void:
	checkpoint_reached = true

func get_respawn_pos() -> Vector2:
	if checkpoint_reached:
		return spawn_checkpoint.position
	else:
		return spawn.position

func _on_game_won() -> void:
	print("WON")
	game_won.show()

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
