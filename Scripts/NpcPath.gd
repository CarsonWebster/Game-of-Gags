class_name NpcPath
extends PathFollow2D

signal finished_walk(this)
var walker: Npc

@export var pixel_speed = 40.0
var in_use = false

# Called when the node enters the scene tree for the first time.
func _ready():
	loop = false
	rotates = false
	walker = get_child(0)

#if the path is in use, we walk along the path. If we finish our walk, throw a signal
func _physics_process(delta):
	if not in_use:
		return
	progress += pixel_speed * delta
	if progress_ratio >= 1:
		reset()
		finished_walk.emit($".")

func set_in_use(b: bool):
	in_use = b
	walker.add_to_group("active_npcs")
	#if progress == 0.0 && in_use:
	#	walker.add_to_group("active_npcs")
	
func reset():
	progress_ratio = 0.0
	walker.remove_from_group("active_npcs")
