extends Area2D

const wall_size := 64

var y_min := 0.0
var y_max := 0.0

@export var player_id := 0
@export var speed := 800


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

	var screen_size := get_viewport_rect().size

	var collision_shape := get_node("CollisionShape2D")
	var paddle_size: float = collision_shape.shape.extents.y * 2

	y_min = wall_size
	y_max = screen_size.y - wall_size - paddle_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity := Vector2.ZERO

	if player_id == 0:
		if Input.is_action_pressed("left_move_up"):
			velocity.y = -1

		if Input.is_action_pressed("left_move_down"):
			velocity.y = 1
	
	elif player_id == 1:
		if Input.is_action_pressed("right_move_up"):
			velocity.y = -1

		if Input.is_action_pressed("right_move_down"):
			velocity.y = 1
		

	position += velocity * speed * delta

	if position.y < y_min:
		position.y = y_min
	elif position.y > y_max:
		position.y = y_max
