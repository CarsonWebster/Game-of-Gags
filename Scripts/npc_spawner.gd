class_name NpcSpawner
extends Node2D

const max_npcs = 3

@export var npc: PackedScene
@export var npc_list: Node2D
@export var direction: Vector2
@onready var timer = $Timer
var rng = RandomNumberGenerator.new()

#readies a timer that spawns the first npc after a short time
func _ready():
	print("starting")
	timer.one_shot = true
	var rand = rng.randf_range(0.0, 2.0)
	timer.start(rand)

#spawns an npc at this location and makes it move in the given direction
func spawn_npc():
	print(name, " is spawning")
	var instance = npc.instantiate()
	npc_list.add_child(instance)
	instance.name = "npc"
	instance.position = position
	instance.set_direction(direction)
	
	
#checks total number of npcs tracked by npc_list
func num_npcs() -> int:
	var count = 0
	for child in npc_list.get_children():
		print(child.name)
		if child.name.begins_with("npc"):
			count = count + 1
	return count

#when the timer fires, if there is room for another npc, one spawns
func _on_timer_timeout():
	if num_npcs() < max_npcs:
		spawn_npc()
	timer.start(rng.randf_range(5.0, 10.0))
