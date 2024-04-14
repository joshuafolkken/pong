class_name Hud
extends CanvasLayer

const MAX_SCORE = 5

var score_left := MAX_SCORE
var score_right := MAX_SCORE

@onready var score_left_label: Label = $Scores/ScoreLeftLabel
@onready var score_right_label: Label = $Scores/ScoreRightLabel


func show_scores() -> void:
	score_left_label.text = str(score_left)
	score_right_label.text = str(score_right)
	show()


func _ready() -> void:
	show_scores()


func reset_socre() -> void:
	score_left = 0
	score_right = 0


func start() -> void:
	reset_socre()
	show_scores()
	await get_tree().create_timer(2.0).timeout
	hide()


func has_winner() -> bool:
	return score_left >= MAX_SCORE or score_right >= MAX_SCORE
