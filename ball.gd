extends CharacterBody2D

const INIT_SPEED = 200
const ACCELERATION = 10

var speed := INIT_SPEED
var direction := Vector2.ONE

func _ready() -> void:
	velocity = Vector2(-3, 1)


func _physics_process(delta: float) -> void:
	velocity = velocity.normalized()
	velocity = velocity * speed * delta

	var collision := move_and_collide(velocity)

	if collision:

		var collider: Node2D = collision.get_collider()

		if collider.is_in_group("paddle"):
			print("paddle")
			velocity = velocity.bounce(collision.get_normal())
			speed += ACCELERATION

			# var paddle_position_y := collider.global_position.y
			# var distance := global_position.y - paddle_position_y
			# var max_distance: int = collider.get_node("CollisionShape2D").shape.extents.y
			# var normalizerd_distance := distance / max_distance
			# var angle := normalizerd_distance * (PI / 4)

			# # velocity.x *= 1
			# # velocity.y = normalizerd_distance

			# speed += ACCELERATION
			# # velocity = velocity.normalized() * speed * delta

			# velocity = velocity.bounce(collision.get_normal()).rotated(angle)
		elif collider.is_in_group("wall"):
			print("wall")
			velocity = velocity.bounce(collision.get_normal())
		elif collider.is_in_group("goal"):
			print("goal")
			position = Vector2(600, 450)
		else:
			print("Invalid collision")
