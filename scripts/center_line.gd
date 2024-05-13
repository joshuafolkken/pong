extends Node2D

const FROM := Vector2(0, 0)
const TO := Vector2(0, 900)
const COLOR := Color(0, 1, 1, 1)
const WIDTH := 24.0
const DASH_LENGTH := 33.5


func _draw() -> void:
	draw_dashed_line(FROM, TO, COLOR, WIDTH, DASH_LENGTH)


func _process(_delta: float) -> void:
	pass
