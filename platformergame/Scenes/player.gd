extends CharacterBody2D
class_name Player

@export var max_speed := 180.0
@export var jump_force := 450.0
@export var max_jumps := 2
@export var gravity := 1600.0

@onready var visuals: Node2D = $Visuals
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = %RayCast2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var jumps_left : int 
var move_direction := 1
var can_move := true

func _ready() -> void:
	jumps_left = max_jumps

func _physics_process(delta: float) -> void:
	if not can_move:
		return
		
	handle_movement()
	handle_gravity(delta)
	handle_wall_collision()
	handle_jump_input()
	move_and_slide()

func handle_movement() -> void:
	velocity.x = move_direction * max_speed
	if is_on_floor():
		animated_sprite_2d.play("run")
		jumps_left = max_jumps

func handle_gravity(delta:float) -> void:
	if not is_on_floor():
		velocity.y += gravity*delta

func handle_jump_input() -> void:
	if not Input.is_action_just_pressed("tap"):
		return
	if ray_cast_2d.is_colliding():
		change_direction()
		jump()
	else:
		jump()

func jump() -> void:
	if jumps_left <= 0:
		return
	SoundManager.play_jump()
	velocity.y = -jump_force
	jumps_left -= 1
	if jumps_left <= 0:
		animated_sprite_2d.play("double_jump")
	else:
		animated_sprite_2d.play("jump")
		
func handle_wall_collision() -> void:
	if not ray_cast_2d.is_colliding():
		return
	
	velocity.y = 50
	jumps_left = max_jumps
	animated_sprite_2d.play("fall")
	
	if is_on_floor():
		change_direction()


func change_direction() -> void:
	move_direction *= -1
	visuals.scale.x *= -1

func player_dead() -> void:
	can_move = false
	velocity = Vector2.ZERO
	animated_sprite_2d.play("defeat")
	collision_shape_2d.set_deferred("disabled", true) 
	
func player_respawn() -> void:
	animated_sprite_2d.play("respawn")
	await animated_sprite_2d.animation_finished
	can_move = true
	collision_shape_2d.set_deferred("disabled", false) 
