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
@onready var control: MainControl = get_node("/root/Main/Control")

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
	# control.show_log("move_with_mouse: " + str(position.y))
	return true


func move_with_touch() -> bool:
	if touches.size() == 0: return false

	for index: int in touches.keys():
		var touch_pos := touches[index] as Vector2
		# control.show_log("touch index: %s, pos: %s" % [index, str(touch_pos)])
		# if touch_pos.y < 0 or touch_pos.y > screen_size.y: continue

		match player_id:
			0: if touch_pos.x > screen_size.x / 2: continue
			1: if touch_pos.x < screen_size.x / 2: continue
			_: pass

		position.y = clamp(touch_pos.y, y_min, y_max)
		# control.show_log("move_with_touch: " + str(position.y))

	touches.clear()

	return true


func move_with_keyboard(delta: float) -> void:
	var velocity_ := Vector2.ZERO

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
	position.y = clamp(position.y, y_min, y_max)


func _process(delta: float) -> void:
	if move_with_touch(): return
	# if move_with_mouse(): return
	move_with_keyboard(delta)


func set_visibility(visibility: bool) -> void:
	visible = visibility
	collision_shere_2d.disabled = !visibility


var touches: Dictionary = {}

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		var touch_event := event as InputEventScreenTouch

		if touch_event.pressed:
			touches[touch_event.index] = touch_event.position
			# control.show_log("touche event pressed: " + str(touch_event.position))

	elif event is InputEventScreenDrag:
		var touch_event := event as InputEventScreenDrag

		touches[touch_event.index] = touch_event.position
		# control.show_log("touche event drag: " + str(touch_event.position))

	elif event is InputEventMouseMotion:
		var mouse_motion := event as InputEventMouseMotion

		touches[0] = mouse_motion.position
		# control.show_log("mouse motion: " + str(mouse_motion.position))

		# is_mouse_moving = mouse_motion.relative.length() > 0
