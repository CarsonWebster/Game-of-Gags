extends Area2D

@export var vertices: Array[Marker2D]
@onready var timer = $Timer
const SPEED = 150.0
var current_vertex: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	go_to_marker(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func choose_other_vertex(index: int) -> int:
	var avails = range(vertices.size())
	avails.remove_at(index)
	return avails.pick_random()

func go_to_marker(index: int):
	var tween = get_tree().create_tween()
	var distance = vertices[index].position.distance_to(position)
	var time = distance / SPEED
	tween.tween_property($".", "position", vertices[index].position, time)
	current_vertex = index
	timer.start(time)

func choose_and_go():
	var to = choose_other_vertex(current_vertex)
	go_to_marker(to)

func _on_timer_timeout():
	choose_and_go()
