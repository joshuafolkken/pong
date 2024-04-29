class_name Beep
extends AudioStreamPlayer2D

const END_TIME := 0.01


func _process(_delta: float) -> void:
	if playing and get_playback_position() >= END_TIME:
		stop()


func play_with_pitch(pitch: float = 1.0) -> void:
	set_pitch_scale(pitch)
	play()


func start() -> void:
	play_with_pitch()


func hit() -> void:
	play_with_pitch(0.5)
