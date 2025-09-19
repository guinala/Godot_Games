extends CharacterBody2D
class_name Rino

@export var ray_length := 165.0
@export var move_speed := 50.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_raycast: RayCast2D = $WallRaycast
@onready var player_raycast: RayCast2D = $PlayerRaycast

var direction := 1
var can_move := false
var defeated := false

func _ready() -> void:
	player_raycast.target_position.x = ray_length

func _process(delta: float) -> void:
	if player_raycast.is_colliding():
		can_move = true
		
	if can_move:
		velocity.x = direction * move_speed
		animated_sprite_2d.play("run")
		move_and_slide()
		
	if wall_raycast.is_colliding():
		can_move = false
		direction *= -1
		animated_sprite_2d.play("hit_wall")
		await get_tree().create_timer(0.8).timeout
		rotate_rino(direction)
		animated_sprite_2d.play("idle")

func rotate_rino(direction: int) -> void:
	animated_sprite_2d.scale.x = direction
	wall_raycast.scale.x = direction
	player_raycast.scale.x = direction



func _on_top_area_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	defeated = true
	can_move = false
	animated_sprite_2d.play("hit")
	await get_tree().create_timer(1.2).timeout
	queue_free()


func _on_bottom_area_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	if defeated:
		return
	EventManager.on_player_dead.emit()
