extends Control

@onready var time_label: Label = $HBoxContainer/TimeLabel
@onready var score_label: Label = $HBoxContainer/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var time_format = "Time Left: %d"
func update_game_timer(time_remaining: float):
	time_label.text = time_format % time_remaining

var score_format = "Time Left: %d"
func update_score(score: float):
	score_label.text = score_format % score

