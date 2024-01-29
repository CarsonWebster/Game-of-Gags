class_name Npc
extends Area2D

const SPEED = 40.0
var direction_vector: Vector2 = Vector2(1, 0)
	
func set_direction(v: Vector2):
	direction_vector = v
	
func play_random_anim():
	var str = ["skylar_walk", "morgan_walk"].pick_random()
	get_child(0).play(str)
