extends Control
class_name MainControl

const MAX_LINES = 8

@onready var label: Label = $Label
@onready var fps_label: Label = $FpsLabel
@onready var game_name: String = ProjectSettings.get_setting("application/config/name")
@onready var game_version: String = ProjectSettings.get_setting("application/config/version")

func _update_log(message: String) -> void:
	var lines := label.text.split("\n")

	if lines.size() > MAX_LINES:
		label.text = "\n".join(lines.slice(lines.size() - MAX_LINES, lines.size()))

	label.text += message + "\n"


func show_log(message: String) -> void:
	_update_log(message)
	print(message)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_log("app started: v0.1")


func _process(_delta: float) -> void:
	var fps := Engine.get_frames_per_second()
	fps_label.text = "FPS:%d %s v%s" % [fps, game_name, game_version]
