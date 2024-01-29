class_name Npc
extends Area2D

var is_in_camera: bool = false

@onready var hud = $ui_container/HUD

const SPEED = 40.0
var direction_vector: Vector2 = Vector2(1, 0)
	
func set_direction(v: Vector2):
	direction_vector = v

func _on_area_entered(area):
	if area.is_in_group("camera"):
		print("NPC IN CAMERA")
		is_in_camera = true
	elif area.is_in_group("banana"):
		print("BANANA")
		get_parent().reset()
		add_score()
	elif area.is_in_group("pie"):
		print("PIED")
		get_parent().reset()
		add_score()
	elif area.is_in_group("npc"):
		#print("npc collision")
		return
	elif area.is_in_group("Player"):
		print("PLAYER")
	else:
		print("None: ", area.get_groups())

func _on_area_exited(area):
	if area.is_in_group("camera"):
		print("NPC EXITED CAMERA")
		is_in_camera = false

func add_score():
	var points = 1
	if is_in_camera:
		points = 5
	hud.add_score(points)
	
func play_random_anim():
	var str = ["skylar_walk", "morgan_walk"].pick_random()
	get_child(0).play(str)
