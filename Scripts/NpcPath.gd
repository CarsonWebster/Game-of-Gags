class_name NpcPath
extends PathFollow2D

signal finished_walk(this)

@export var pixel_speed = 40.0
var in_use = false

# Called when the node enters the scene tree for the first time.
func _ready():
	loop = false
	rotates = false

#if the path is in use, we walk along the path. If we finish our walk, throw a signal
func _physics_process(delta):
	if not in_use:
		return
	progress += pixel_speed * delta
	if progress_ratio >= 1:
		finished_walk.emit($".")

func set_in_use(b: bool):
	in_use = b
	
func reset():
	progress = 0
