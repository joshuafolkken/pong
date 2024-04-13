extends Node2D


func _draw() -> void:
	var from := Vector2(0, 0)
	var to := Vector2(0, 900)
	var color := Color(0, 1, 1, 1)
	var width := 24.0
	var dash_length := 33.5

	draw_dashed_line(from, to, color, width, dash_length)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
