class_name Hud

extends CanvasLayer

const max_score = 15

var score_left := max_score
var score_right:= max_score

@onready var score_left_label: Label = $Scores/ScoreLeftLabel
@onready var score_right_label: Label = $Scores/ScoreRightLabel


func show_scores() -> void:
	score_left_label.text = str(score_left)
	score_right_label.text = str(score_right)
	show()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_scores()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func start() -> void:
	score_left = 0
	score_right = 0

	show_scores()
	await get_tree().create_timer(2.0).timeout
	hide()
