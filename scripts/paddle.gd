class_name Paddle
extends CharacterBody2D

const wall_size := 64

var y_min := 0.0
var y_max := 0.0
var is_mouse_moving := false

@export var player_id := 0
@export var speed := 800

@onready var screen_size := Vector2.ZERO
@onready var collision_shere_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	screen_size = get_viewport_rect().size

	var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
	var rectangle_shape: RectangleShape2D = collision_shape.shape
	var paddle_size: float = rectangle_shape.extents.y * 2

	y_min = 0 + paddle_size / 2
	y_max = screen_size.y - paddle_size / 2


func move_with_mouse() -> bool:
	if not is_mouse_moving: return false

	is_mouse_moving = false

	var mouse_pos := get_viewport().get_mouse_position()
	if mouse_pos.y < 0 or mouse_pos.y > screen_size.y: return false

	match player_id:
		0: if mouse_pos.x > screen_size.x / 2: return false
		1: if mouse_pos.x < screen_size.x / 2: return false
		_: pass

	position.y = mouse_pos.y
	return true


func _process(delta: float) -> void:
	var velocity_ := Vector2.ZERO

	if move_with_mouse(): return

	if player_id == 0:
		if Input.is_action_pressed("left_move_up"):
			velocity_.y = -1

		if Input.is_action_pressed("left_move_down"):
			velocity_.y = 1

	elif player_id == 1:
		if Input.is_action_pressed("right_move_up"):
			velocity_.y = -1

		if Input.is_action_pressed("right_move_down"):
			velocity_.y = 1


	position += velocity_ * speed * delta

	if position.y < y_min:
		position.y = y_min
	elif position.y > y_max:
		position.y = y_max


func set_visibility(visibility: bool) -> void:
	visible = visibility
	collision_shere_2d.disabled = !visibility


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_motion := event as InputEventMouseMotion

		is_mouse_moving = mouse_motion.relative.length() > 0
