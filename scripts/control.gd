extends Control
class_name MainControl

const MAX_LINES = 8

@onready var label: Label = $Label


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
