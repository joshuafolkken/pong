extends TextureButton

@export var on_color := Color(1, 1, 1, 1)
@export var off_color: Color = Color(1, 1, 1, 0.3)

func _ready() -> void:
	toggle_mode = true

	change_color()
	toggled.connect(_on_toggled)


func change_color() -> void:
	if button_pressed:
		modulate = on_color
	else:
		modulate = off_color


func _on_toggled(_toggled_on: bool) -> void:
	change_color()
