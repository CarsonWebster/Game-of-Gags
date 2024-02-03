extends State
class_name PlayerBananaWalk

var player : CharacterBody2D
@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	sprite.play("Banana Walk")

func Exit():
	pass

func Update(_delta:float):
	if Input.is_action_just_pressed("attack1") or Input.is_action_just_released("attack1"):
		# Transition to banana drop
		state_transition.emit(self, "BananaDrop")

func Physics_Update(_delta: float):
	player.do_movement(_delta)
	
	if player.velocity.is_zero_approx():
		sprite.pause()
		sprite.frame = 0
	else:
		sprite.play("Banana Walk")
