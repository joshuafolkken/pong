class_name Main
extends Node2D

enum GameState {
	WAITING,
	PLAYING,
}

enum GameMode {
	single,
	double,
}

@onready var game_state := GameState.WAITING
@onready var game_mode := GameMode.double

@onready var ball: Ball = $Ball
@onready var hud: Hud = $HUD
@onready var left_paddle_2: Paddle = $LeftPaddle2
@onready var right_paddle_2: Paddle = $RightPaddle2
@onready var full_screen_button: TextureButton = $FullScreenButton


func set_paddles() -> void:
	var is_visible := game_mode == GameMode.double

	left_paddle_2.set_visibility(is_visible)
	right_paddle_2.set_visibility(is_visible)


func _ready() -> void:
	full_screen_button.pressed.connect(_on_full_screen_button_pressed)

	ball.hide()
	set_paddles()


func _on_full_screen_button_pressed() -> void:
	var is_full_screen := DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED if is_full_screen else DisplayServer.WINDOW_MODE_FULLSCREEN)


func start() -> void:
	game_state = GameState.PLAYING

	hud.start()

	await get_tree().create_timer(2.0).timeout
	ball.start()


func _input(event: InputEvent) -> void:
	if game_state == GameState.WAITING:
		if event.is_action_pressed("game_start"):
			start()

		if event is InputEventMouseButton:
			var mouse_button := event as InputEventMouseButton

			if mouse_button.button_index == MOUSE_BUTTON_LEFT and mouse_button.pressed:
				start()

	if event.is_action_pressed("game_mode"):
		game_mode = GameMode.single if game_mode == GameMode.double else GameMode.double

		set_paddles()
