extends Control

@export var MenuScene: PackedScene

# Get parent reference
@onready var main = $"../"

func _on_resume_button_pressed():
	main.pauseMenu(main.paused)

func _on_quit_button_pressed():
	get_tree().change_scene_to_packed(MenuScene)
	#get_tree().unload_current_scene()
