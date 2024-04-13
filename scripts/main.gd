class_name Main
extends Node2D

enum GameState {
	waiting,
	playing,
}

enum GameMode {
	single,
	double,
}

@onready var game_state := GameState.waiting
@onready var game_mode := GameMode.double

@onready var ball: Ball = $Ball
@onready var hud: Hud = $HUD
@onready var left_paddle_2: Paddle = $LeftPaddle2
@onready var right_paddle_2: Paddle = $RightPaddle2


func set_paddles() -> void:
	match game_mode:
		GameMode.single:
			left_paddle_2.set_visibility(false)
			right_paddle_2.set_visibility(false)

		GameMode.double:
			left_paddle_2.set_visibility(true)
			right_paddle_2.set_visibility(true)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ball.hide()
	set_paddles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func start() -> void:
	game_state = GameState.playing

	hud.start()

	await get_tree().create_timer(2.0).timeout
	ball.start()



func _input(event: InputEvent) -> void:
	if game_state == GameState.waiting:
		if event.is_action_pressed("game_start"):
			start()

		if event is InputEventMouseButton:
			var mouse_button := event as InputEventMouseButton

			if mouse_button.button_index == MOUSE_BUTTON_LEFT and mouse_button.pressed:
				start()

	if event.is_action_pressed("game_mode"):
		match game_mode:
			GameMode.single:
				game_mode = GameMode.double
			GameMode.double:
				game_mode = GameMode.single

		set_paddles()
