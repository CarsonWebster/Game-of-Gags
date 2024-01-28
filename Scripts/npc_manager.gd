class_name NpcManager
extends Node2D

@onready var paths_node = $Paths
@onready var timer = $NpcTimer

const MAX_NPCS = 2 #must be less than number of paths
var npc_list: Array[Area2D]
var paths_list: Array[NpcPath]
var path_usage: Dictionary #maps PathFollow2D to a bool indicating if they're being walked

#initialize paths_list array and path_usage dictionary, send out initial npcs
func _ready():
	for child in paths_node.get_children():
		if child is Path2D:
			paths_list.append(child.get_child(0))
	for p in paths_list:
		path_usage[p] = false
	initial_x_npcs(MAX_NPCS)
	
func initial_x_npcs(x: int):
	for idx in x:
		activate_path(random_unused_path())

#returns a random path that's not currently being used
func random_unused_path() -> NpcPath:
	var unused_paths: Array = []
	for p in paths_list:
		if path_usage[p] == false:
			unused_paths.append(p)
	return unused_paths.pick_random()

func activate_path(npc_path):
	path_usage[npc_path] = true
	npc_path.in_use = true

func _on_path_follow_2d_finished_walk(path_follow: NpcPath):
	path_usage[path_follow] = false
	path_follow.in_use = false
	path_follow.reset()
	var new_path = random_unused_path()
	activate_path(new_path)
