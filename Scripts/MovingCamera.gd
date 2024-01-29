extends Node2D

@onready var corrners = $Corrners
@onready var offset_timer = $OffsetTimer
@onready var state_timer = $StateTimer
@export var cam_square: Area2D
@export var cam_paths: Array[PathFollow2D]
const move_to_speed = 80.0
const hover_speed = 40.0
const max_offset: float = 2.0

enum State {
	GO_TO_POSITION,
	HOVER_ON_POSITION,
	GO_TO_PATH,
	HOVER_ON_PATH,
	GO_TO_NPC,
	HOVER_ON_NPC,
}

var current_state: State = State.GO_TO_POSITION
var target: Node #either a point, an npc, or a PathFollow2D
var offset: Vector2
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	state_timer.start(10.0)
	choose_new_target()

func _process(delta):
	if [State.GO_TO_POSITION, State.GO_TO_PATH, State.GO_TO_NPC].has(current_state):
		cam_square.position = cam_square.position.move_toward(target.position, delta * move_to_speed)
		if cam_square.position == target.position:
			choose_next_state()
	elif [State.HOVER_ON_POSITION, State.HOVER_ON_NPC, State.HOVER_ON_PATH].has(current_state):
		#print(target)
		cam_square.position = cam_square.position.move_toward(target.position + offset, delta * hover_speed)

func randomize_offset():
	offset = Vector2(rng.randf_range(-max_offset, max_offset), rng.randf_range(-max_offset, max_offset))

func choose_next_state():
	if current_state == State.GO_TO_NPC:
		current_state = State.HOVER_ON_NPC
	elif current_state == State.GO_TO_POSITION:
		current_state = State.HOVER_ON_POSITION
	elif current_state == State.GO_TO_PATH:
		current_state = State.HOVER_ON_PATH
	else:
		current_state = [State.GO_TO_POSITION, State.GO_TO_PATH, State.GO_TO_NPC].pick_random()
		choose_new_target()
	print("new state: ", current_state)

func choose_new_target():
	if current_state == State.GO_TO_NPC:
		var actives = get_tree().get_nodes_in_group("active_npcs")
		if actives.size() > 0:
			target = get_tree().get_nodes_in_group("active_npcs").pick_random().get_parent()
		else:
			target = cam_paths.pick_random()
	elif current_state == State.GO_TO_PATH:
		target = cam_paths.pick_random()
	elif current_state == State.GO_TO_POSITION:
		target = corrners.get_children().pick_random()

func _on_offset_timer_timeout():
	randomize_offset()

func _on_state_timer_timeout():
	choose_next_state()
