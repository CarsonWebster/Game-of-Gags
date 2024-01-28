extends Control

@onready var time_label: Label = $HBoxContainer/TimeLabel
@onready var score_label: Label = $HBoxContainer/ScoreLabel
@onready var bananas_label: Label = $HBoxContainer/BananasLabel
@onready var shocks_label: Label = $HBoxContainer/ShocksLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	CollectableSignalBus.on_update_banana.connect(update_banana)
	CollectableSignalBus.on_update_shock.connect(update_shock)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

var time_format = "Time Left: %d"
func update_game_timer(time_remaining: float):
	time_label.text = time_format % time_remaining

var score_format = "Time Left: %d"
func update_score(score: float):
	score_label.text = score_format % score

var bananas_format = "Bananas: %d"
func update_banana(current) -> void:
	bananas_label.text = bananas_format % current

var shocks_format = "Shocks: %d"
func update_shock(current) -> void:
	shocks_label.text = shocks_format % current
