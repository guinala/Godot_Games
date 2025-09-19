extends CharacterBody2D
class_name EnemyBird 

@export var path: CustomPathFollow
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dead := false

func _process(delta: float) -> void:
	animated_sprite_2d.flip_h = path.direction == 1



func _on_top_area_body_entered(body: Node2D) -> void:
	if not body is Player:
		return 
	path.can_move = false
	animated_sprite_2d.play("hit")
	body.velocity.y = -250
	dead = true
	
	await animated_sprite_2d.animation_finished
	queue_free()


func _on_bottom_area_body_entered(body: Node2D) -> void:
	if not body is Player:
		return 
	if dead:
		return
	EventManager.on_player_dead.emit()
