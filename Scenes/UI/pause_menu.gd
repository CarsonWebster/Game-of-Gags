extends Control

@onready var resume_button: Button = $MarginContainer/PanelContainer/CenterContainer/VBoxContainer/ResumeButton
@onready var pause_music: AudioStreamPlayer = $PauseMusic

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_music.playing = false

func focus_resume_button():
	resume_button.grab_focus()
	pause_music.playing = true


func _on_resume_button_pressed():
	hide()
	pause_music.playing = false
	await get_tree().create_timer(.1, true, false, false).timeout
	get_tree().paused = false


func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game/main_menu.tscn")
