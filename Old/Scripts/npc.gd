class_name Npc
extends Area2D

var is_in_camera: bool = false

#@onready var hud = $ui_container/HUD

const SPEED = 40.0
var direction_vector: Vector2 = Vector2(1, 0)
	
func set_direction(v: Vector2):
	direction_vector = v

func _on_area_entered(area):
	if area.is_in_group("camera"):
		#print("NPC IN CAMERA")
		is_in_camera = true
	elif area.is_in_group("banana"):
		#print("BANANA")
		#await $AnimatedSprite2D.play("")
		get_parent().reset()
		add_score()
	elif area.is_in_group("pie"):
		#print("PIED")
		get_parent().reset()
	elif area.is_in_group("npc"):
		#print("npc collision")
		pass
	elif area.is_in_group("Player"):
		#print("PLAYER")
		pass
	else:
		print("None: ", area.get_groups())

func _on_area_exited(area):
	if area.is_in_group("camera"):
		#print("NPC EXITED CAMERA")
		is_in_camera = false

func add_score():
	var _points = 1
	if is_in_camera:
		_points = 5

func play_random_anim():
	var names = ["skylar_walk", "morgan_walk", "oliver_walk"].pick_random()
	get_child(0).play(names)
