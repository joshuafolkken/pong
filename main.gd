extends Node2D

@onready var ball: Ball = $Ball
@onready var hud: Hud = $HUD

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ball.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func start() -> void:
	hud.start()

	await get_tree().create_timer(2.0).timeout
	ball.start()



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("game_start"):
		start()
