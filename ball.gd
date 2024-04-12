extends CharacterBody2D

const INIT_SPEED = 300
const ACCELERATION = 10

var speed := INIT_SPEED
var direction := Vector2.ONE
var screen_width := 0.0

@onready var beep: Beep = get_node("/root/Main/Beep")

func _ready() -> void:
	screen_width = get_viewport_rect().size.x
	velocity = Vector2(-3, 1)
	beep.start()


func _physics_process(delta: float) -> void:
	velocity = velocity.normalized()
	velocity = velocity * speed * delta

	var collision := move_and_collide(velocity)

	if collision:
		beep.hit()
		var collider: Node2D = collision.get_collider()

		if collider.is_in_group("paddles"):
			# print("paddle")
			# velocity = velocity.bounce(collision.get_normal())
			speed += ACCELERATION

			var paddle_position_y := collider.position.y
			var hit_pos := position.y - paddle_position_y
			var max_distance: int = collider.get_node("CollisionShape2D").shape.extents.y
			var normalizerd_distance := hit_pos / max_distance
			var angle := normalizerd_distance * (PI / 4)
			var direction := Vector2.RIGHT.rotated(angle)

			if collider.is_in_group("left_paddle"):
				direction.x = abs(direction.x)
			else:
				direction.x = -abs(direction.x)

			velocity = velocity.length() * direction

		elif collider.is_in_group("wall"):
			print("wall")
			velocity = velocity.bounce(collision.get_normal())
		elif collider.is_in_group("goal"):
			print("goal")
			position = Vector2(600, 450)
		else:
			print("Invalid collision")

	var half_width := screen_width * 0.5
	if position.x < half_width:
		var ratio := position.x / half_width
		modulate = Color(0, 1, 0, 1).lerp(Color(0, 1, 1, 1), ratio)
	else:
		var ratio := (position.x - half_width) / half_width
		modulate = Color(0, 1, 1, 1).lerp(Color(1, 0, 1, 1), ratio) # 紫

	# var x_ratio := position.x / screen_width
	# var color := Color.GREEN.lerp(Color(1, 0, 1, 1), x_ratio)

	# modulate = color
