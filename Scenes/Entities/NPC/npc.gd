extends CharacterBody2D

@export var movement_speed: float = 50.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	pass
	navigation_agent.target_position = get_tree().get_first_node_in_group("Player").global_position
	#velocity = (navigation_agent.get_next_path_position() - global_position).normalized() * movement_speed

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return
	
	navigation_agent.target_position = get_tree().get_first_node_in_group("Player").global_position
	
	velocity = (navigation_agent.get_next_path_position() - global_position).normalized() * movement_speed
	
	move_and_slide()
