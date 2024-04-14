class_name Ball
extends CharacterBody2D

const INIT_SPEED = 300
const ACCELERATION = 10
const PADDLE_HIT_ANGLE_RANGE = PI / 4

var speed := INIT_SPEED
var direction := Vector2.ONE
var screen_size := Vector2.ZERO

@onready var main: Main = get_node("/root/Main")
@onready var beep: Beep = get_node("/root/Main/Beep")
@onready var hud: Hud = get_node("/root/Main/HUD")


func _ready() -> void:
	screen_size = get_viewport_rect().size
	velocity = Vector2(-3, 1)
	position = Vector2(screen_size.x / 2, screen_size.y / 2)


func show_ball() -> void:
	position = Vector2(screen_size.x / 2, screen_size.y / 2)
	beep.start()
	show()


func start() -> void:
	speed = INIT_SPEED
	show_ball()


func update_ball_color() -> void:
	var half_width := screen_size.y * 0.5

	if position.x < half_width:
		var ratio := position.x / half_width
		modulate = Color(0, 1, 0, 1).lerp(Color(0, 1, 1, 1), ratio)
	else:
		var ratio := (position.x - half_width) / half_width
		modulate = Color(0, 1, 1, 1).lerp(Color(1, 0, 1, 1), ratio)


func handle_paddle_collision(collision: KinematicCollision2D, collider: Node2D) -> void:
	beep.hit()
	speed += ACCELERATION

	var paddle_position_y := collider.position.y
	var hit_pos := position.y - paddle_position_y
	var max_distance: int = collider.get_node("CollisionShape2D").shape.extents.y
	var normalizerd_distance := hit_pos / max_distance
	var angle := normalizerd_distance * PADDLE_HIT_ANGLE_RANGE
	var direction := Vector2.RIGHT.rotated(angle)

	if velocity.x < 0:
		direction.x = abs(direction.x)
	else:
		direction.x = -abs(direction.x)

	velocity = velocity.length() * direction


func handle_wall_collision(collision: KinematicCollision2D) -> void:
	beep.hit()
	velocity = velocity.bounce(collision.get_normal())


func handle_goal_collision(collider: Node2D) -> void:
	beep.hit()

	if collider.is_in_group("left_goal"):
		hud.score_right += 1
	else:
		hud.score_left += 1
	goal()

func handle_collision(collision: KinematicCollision2D) -> void:
	var collider: Node2D = collision.get_collider()

	if collider.is_in_group("paddles"):
		handle_paddle_collision(collision, collider)

	elif collider.is_in_group("walls"):
		handle_wall_collision(collision)

	elif collider.is_in_group("goals"):
		handle_goal_collision(collider)

	else:
		print("Invalid collision")


func _physics_process(delta: float) -> void:
	if not is_visible(): return

	velocity = velocity.normalized() * speed * delta

	var collision := move_and_collide(velocity)

	if collision:
		handle_collision(collision)

	update_ball_color()


func goal() -> void:
	hide()
	hud.show_scores()

	if hud.has_winner():
		main.game_state = main.GameState.WAITING
		return

	await get_tree().create_timer(2.0).timeout

	hud.hide()
	velocity.x *= -1
	show_ball()
