extends Area2D
class_name Fruit

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var collected := false




func _on_body_entered(body: Node2D) -> void:
	if collected:
		return
		
	collected = true
	animated_sprite_2d.play("collected")
	EventManager.on_fruit_collected.emit()
	await get_tree().create_timer(0.5).timeout
	queue_free()
