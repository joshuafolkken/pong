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
@onready var settings: Settings = $Settings
@onready var retro_canvas_layer: CanvasLayer = $RetroCanvasLayer
@onready var retro_button: TextureButton = $Buttons/RetroButton
@onready var music_button: TextureButton = $Buttons/MusicButton
@onready var full_screen_button: TextureButton = $Buttons/FullScreenButton
@onready var music: AudioStreamPlayer2D = $Music


func set_paddles() -> void:
	var is_dubble_paddle := settings.load_double_paddle()

	left_paddle_2.set_visibility(is_dubble_paddle)
	right_paddle_2.set_visibility(is_dubble_paddle)


func _retro_mode() -> void:
	retro_canvas_layer.visible = settings.load_retro_mode()


func _music() -> void:
	var is_music_enabled := settings.load_music()

	if is_music_enabled:
		music.play()
	else:
		music.stop()


func _on_retro_button_pressed(toggle_on: bool) -> void:
	settings.save_retro_mode(toggle_on)
	_retro_mode()


func _on_music_button_pressed(toggle_on: bool) -> void:
	settings.save_music(toggle_on)
	_music()


func _is_full_screen() -> bool:
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN


func _full_screen() -> void:
	if full_screen_button.button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_full_screen_button_pressed(toggle_on: bool) -> void:
	# settings.save_full_screen(toggle_on)
	_full_screen()


func _ready() -> void:
	print("fullscreen: " + str(_is_full_screen()))

	retro_button.button_pressed = settings.load_retro_mode()
	music_button.button_pressed = settings.load_music()
	full_screen_button.button_pressed = _is_full_screen()

	ball.hide()
	set_paddles()
	_retro_mode()
	_music()
	# _full_screen()

	retro_button.toggled.connect(_on_retro_button_pressed)
	music_button.toggled.connect(_on_music_button_pressed)
	full_screen_button.toggled.connect(_on_full_screen_button_pressed)


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
