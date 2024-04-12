class_name Ball
extends CharacterBody2D

const INIT_SPEED = 300
const ACCELERATION = 10

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


func _physics_process(delta: float) -> void:
	if not is_visible():
		return

	velocity = velocity.normalized()
	velocity = velocity * speed * delta

	var collision := move_and_collide(velocity)

	if collision:
		var collider: Node2D = collision.get_collider()

		if collider.is_in_group("paddles"):
			var paddle: Paddle = collider as Paddle

			# if (paddle.player_id == 0 and velocity.x < 0) or (paddle.player_id == 1 and velocity.x > 0):
			print("hit")
			beep.hit()

			# print("paddle")
			# velocity = velocity.bounce(collision.get_normal())
			speed += ACCELERATION

			var paddle_position_y := collider.position.y
			var hit_pos := position.y - paddle_position_y
			var max_distance: int = collider.get_node("CollisionShape2D").shape.extents.y
			var normalizerd_distance := hit_pos / max_distance
			var angle := normalizerd_distance * (PI / 4)
			var direction := Vector2.RIGHT.rotated(angle)

			if velocity.x < 0:
				direction.x = abs(direction.x)
			else:
				direction.x = -abs(direction.x)

			# if collider.is_in_group("left_paddle"):
			# 	direction.x = abs(direction.x)
			# else:
			# 	direction.x = -abs(direction.x)

			velocity = velocity.length() * direction

			# else:
			# 	velocity = velocity.bounce(collision.get_normal())
				# print("back hit")


		elif collider.is_in_group("walls"):
			beep.hit()
			velocity = velocity.bounce(collision.get_normal())

		elif collider.is_in_group("goals"):
			beep.hit()

			if collider.is_in_group("left_goal"):
				hud.score_right += 1
			else:
				hud.score_left += 1
			goal()
		else:
			print("Invalid collision")

	var half_width := screen_size.y * 0.5

	if position.x < half_width:
		var ratio := position.x / half_width
		modulate = Color(0, 1, 0, 1).lerp(Color(0, 1, 1, 1), ratio)
	else:
		var ratio := (position.x - half_width) / half_width
		modulate = Color(0, 1, 1, 1).lerp(Color(1, 0, 1, 1), ratio) # 紫


func goal() -> void:
	hide()
	hud.show_scores()

	if hud.is_game_over():
		main.game_state = main.GameState.waiting
		return

	await get_tree().create_timer(2.0).timeout

	hud.hide()
	show_ball()
