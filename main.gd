extends Node2D

# const initial_ball_speed := 80
# const pad_speed = 150

# var ball_speed := initial_ball_speed

# var screen_size := Vector2.ZERO
# var pad_size := Vector2.ZERO
# var direction := Vector2(1.0, 0.0)

@onready var left_paddle: Area2D = $LeftPaddle


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# screen_size = get_viewport_rect().size

	# var collision_shape: CollisionShape2D = left_paddle.get_node("CollisionShape2D")
	# pad_size = collision_shape.shape.extents * 2

	# print(pad_size)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
