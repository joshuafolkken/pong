class_name Settings
extends Node

const SETTING_FILE_PATH = "user://settings.cfg"

const GAME_SECTION = "game"
const VIDEO_SECTION = "video"
const AUDIO_SECTION = "audio"

const DOUBLE_PADDLE: Array[String] = [GAME_SECTION, "double_paddle"]

const RETRO_MODE: Array[String] = [VIDEO_SECTION, "retro_mode"]
const FULL_SCREEN: Array[String] = [VIDEO_SECTION, "full_screen"]
const SCREEN_SNAKE: Array[String] = [VIDEO_SECTION, "screen_snake"]

const MUISC: Array[String] = [AUDIO_SECTION, "music"]
const MASTER_VOLUME: Array[String] = [AUDIO_SECTION, "master_volume"]
const SFX_VOLUME: Array[String] = [AUDIO_SECTION, "sfx_volume"]

@export var double_paddle := true

@export var retro_mode := true
@export var full_screen := true
@export var screen_shake := true
@export var music := true

@export_range(0, 1, 0.1) var master_volume := 1.0
@export_range(0, 1, 0.1) var sfx_volume := 1.0

var config := ConfigFile.new()


func _ready() -> void:
	if !FileAccess.file_exists(SETTING_FILE_PATH):
		config.set_value(DOUBLE_PADDLE[0], DOUBLE_PADDLE[1], double_paddle)

		config.set_value(RETRO_MODE[0], RETRO_MODE[1], retro_mode)
		config.set_value(FULL_SCREEN[0], FULL_SCREEN[1], full_screen)
		config.set_value(SCREEN_SNAKE[0], SCREEN_SNAKE[1], screen_shake)

		config.set_value(MUISC[0], MUISC[1], music)
		config.set_value(MASTER_VOLUME[0], MASTER_VOLUME[1], master_volume)
		config.set_value(SFX_VOLUME[0], SFX_VOLUME[1], sfx_volume)

		config.save(SETTING_FILE_PATH)

	else:
		config.load(SETTING_FILE_PATH)


func _save_settings(section: String, key: String, value: Variant) -> void:
	config.set_value(section, key, value)
	config.save(SETTING_FILE_PATH)


func load_settings(section: String, key: String, default: Variant) -> Variant:
	return config.get_value(section, key, default)


func save_double_paddle(value: bool) -> void:
	_save_settings(DOUBLE_PADDLE[0], DOUBLE_PADDLE[1], value)


func load_double_paddle() -> bool:
	return load_settings(DOUBLE_PADDLE[0], DOUBLE_PADDLE[1], double_paddle)


func save_retro_mode(value: bool) -> void:
	_save_settings(RETRO_MODE[0], RETRO_MODE[1], value)


func load_retro_mode() -> bool:
	return load_settings(RETRO_MODE[0], RETRO_MODE[1], retro_mode)


func save_full_screen(value: bool) -> void:
	_save_settings(FULL_SCREEN[0], FULL_SCREEN[1], value)


func load_full_screen() -> bool:
	return load_settings(FULL_SCREEN[0], FULL_SCREEN[1], full_screen)


func save_music(value: bool) -> void:
	_save_settings(MUISC[0], MUISC[1], value)


func load_music() -> bool:
	return load_settings(MUISC[0], MUISC[1], music)
