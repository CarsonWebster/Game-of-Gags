extends State
class_name PlayerPieWalk

var player : CharacterBody2D
@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	sprite.play("Pie Walk")

func Exit():
	pass

func Update(_delta:float):
	if Input.is_action_just_pressed("attack2") or Input.is_action_just_released("attack2"):
		# Transition to banana drop
		state_transition.emit(self, "PieThrow")

func Physics_Update(_delta: float):
	player.do_movement(_delta)
	
	if player.velocity.is_zero_approx():
		sprite.pause()
		sprite.frame = 0
	else:
		sprite.play("Pie Walk")
