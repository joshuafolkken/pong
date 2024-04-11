extends CharacterBody2D

const speed = 200

var direction := Vector2.ONE


func _ready() -> void:
	velocity = Vector2(-3, 1)


func _physics_process(delta: float) -> void:
	velocity = velocity.normalized()
	velocity = velocity * speed * delta

	var collision_data := move_and_collide(velocity)

	if collision_data:
		# velocity.y += randf_range(-20, 20)
		velocity = velocity.bounce(collision_data.get_normal())
	#position *= direction * speed * delta
#
	#move_and_slide()
