extends Node

@export var victim_scene: PackedScene
@export var victims: Node2D
@export var victim_spawn_timer_amount: float = 2.5

@onready var spawn_timer = $Timer
@onready var spawn_points = $SpawnPoints

var possible_points
var selected_spawn_point

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer.start(victim_spawn_timer_amount)
	#print("Spawn Points: ", spawn_points)
	possible_points = spawn_points.get_children()
	#print("Possible Points: ", possible_points) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_timer_timeout():
	spawn_victim()

func spawn_victim():
	selected_spawn_point = possible_points.pick_random()
	#print("Selected Spawn ", selected_spawn_point)
	var victim = victim_scene.instantiate()
	victims.add_child(victim)
	victim.position = selected_spawn_point.position
	#print("Spawned: ", victim, "at: ", victim.position)
