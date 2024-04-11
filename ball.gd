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
		velocity = velocity.bounce(collision.get_normal())

		var collider: Node = collision.get_collider()

		if collider.is_in_group("paddle"):
			speed += ACCELERATION
		# velocity.y += randf_range(-20, 20)
	#position *= direction * speed * delta
#
	#move_and_slide()
