extends CharacterBody2D

const speed = 200

var direction := Vector2.ONE


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	pass
	#position *= direction * speed * delta
#
	#move_and_slide()
