extends State
class_name PlayerWalk

var player : CharacterBody2D

@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	sprite.play("Walk")

func Exit():
	pass
	
func Update(_delta):
	player.check_attacks(self)

func Physics_Update(_delta:float):
	# Player movement calculations
	player.do_movement(_delta)
	
	if player.velocity.is_zero_approx():
		state_transition.emit(self, "Idle")
