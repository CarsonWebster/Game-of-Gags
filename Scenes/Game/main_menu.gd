extends Control

@onready var start_button = $PanelContainer/VBoxContainer/StartButton as Button

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	start_button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Game/city_level.tscn")
