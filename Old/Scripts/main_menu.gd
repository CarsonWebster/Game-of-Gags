extends Node

@export var GameScene: PackedScene

func _ready():
	$PlayMusic.play()

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(GameScene)
	
