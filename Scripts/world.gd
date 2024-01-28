extends Node2D

@onready var pause_menu = $ui_container/PauseMenu
@onready var hud = $ui_container/HUD
@onready var game_timer = $GameTimer
@onready var game_music = $GameMusic
var paused: bool = false

func _ready():
	paused = false
	game_music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		togglePause(paused)
	hud.update_game_timer(game_timer.time_left)

func togglePause(state):
	if state:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause_menu.hide()
		get_tree().paused = false

	else:
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		pause_menu.show()
		pause_menu.open_pause_menu()
	
	paused = !paused

func _on_game_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
