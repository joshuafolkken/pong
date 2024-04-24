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

@onready var ball: Ball = $Ball
@onready var hud: Hud = $HUD
@onready var left_paddle_2: Paddle = $LeftPaddle2
@onready var right_paddle_2: Paddle = $RightPaddle2
@onready var full_screen_button: TextureButton = $FullScreenButton
@onready var settings: Settings = $Settings
@onready var retro_canvas_layer: CanvasLayer = $RetroCanvasLayer
@onready var retro_button: TextureButton = $Control/RetroButton


func set_paddles() -> void:
	var is_dubble_paddle := settings.load_double_paddle()

	left_paddle_2.set_visibility(is_dubble_paddle)
	right_paddle_2.set_visibility(is_dubble_paddle)


func _retro_mode() -> void:
	retro_canvas_layer.visible = settings.load_retro_mode()


func _on_retro_button_pressed(toggle_on: bool) -> void:
	settings.save_retro_mode(toggle_on)
	_retro_mode()


func _ready() -> void:
	retro_button.button_pressed = settings.load_retro_mode()

	ball.hide()
	set_paddles()
	_retro_mode()

	full_screen_button.pressed.connect(_on_full_screen_button_pressed)
	retro_button.toggled.connect(_on_retro_button_pressed)


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
		var is_double_paddle := settings.load_double_paddle()
		settings.save_double_paddle(not is_double_paddle)

		set_paddles()
