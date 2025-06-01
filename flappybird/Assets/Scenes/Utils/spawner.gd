extends Node
class_name Spawner

signal on_obstacle_crash 
signal on_player_score

const OBSTACULO = preload("res://Assets/Scenes/Obstacle/obstáculo.tscn")

@onready var timer: Timer = $Timer

func spawn_obstacle() -> void:
	var obst_instantiate : Obstacle = OBSTACULO.instantiate()
	obst_instantiate.on_player_crashed.connect(_on_player_crashed)
	obst_instantiate.on_player_scored.connect(_on_player_scored)
	
	var viewport : Viewport = get_viewport()
	obst_instantiate.position.x = viewport.get_visible_rect().end.x + 150
	
	var half_height = viewport.size.y / 2
	obst_instantiate.position.y = randf_range(half_height+300, half_height-50)

	add_child(obst_instantiate)

func _on_timer_timeout() -> void:
	spawn_obstacle()

func _on_player_crashed() -> void:
	on_obstacle_crash.emit()
	stop_obstacles()

func _on_player_scored() -> void:
	on_player_score.emit()

func stop_obstacles() -> void:
	timer.stop()
	
	for obs:Obstacle in get_children().filter(func(x): return x is Obstacle):
		obs.set_speed(0)
