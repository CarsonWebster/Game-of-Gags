extends State
class_name PlayerIdle

var player : CharacterBody2D
@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	sprite.play("Idle")

func Update(_delta: float):
	
	player.check_attacks(self)
	
	var direction: Vector2 = Vector2(Input.get_axis("walk_left", "walk_right"), Input.get_axis("walk_up", "walk_down"))
	if not direction.is_zero_approx():
		state_transition.emit(self, "Walk")

func Exit():
	pass
