class_name Beep

extends AudioStreamPlayer2D

var end_time := 0.01


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if playing and get_playback_position() >= end_time:
		stop()


func play_with_pitch(pitch: float = 1.0) -> void:
	set_pitch_scale(pitch)
	play()


func start() -> void:
	play_with_pitch(1.0)


func hit() -> void:
	play_with_pitch(0.5)
