extends State
class_name PlayerIdle

var player : CharacterBody2D
@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	sprite.play("Idle")

func Update(_delta: float):
	
	var direction: Vector2 = Vector2(Input.get_axis("walk_left", "walk_right"), Input.get_axis("walk_up", "walk_down"))
	
	if Input.is_action_just_pressed("attack1") or Input.is_action_just_released("attack1"):
		# Transition to banana drop
		state_transition.emit(self, "BananaDrop")
	if Input.is_action_pressed("attack1"):
		# Switch to banana walk
		state_transition.emit(self, "BananaWalk")
	if Input.is_action_just_pressed("attack2") or Input.is_action_just_released("attack2"):
		# Transition to pie throw
		state_transition.emit(self, "PieThrow")
	if Input.is_action_pressed("attack2"):
		# Switch to banana walk
		state_transition.emit(self, "PieWalk")
	if Input.is_action_just_pressed("attack3") or Input.is_action_just_released("attack3"):
		# Transition to shock
		state_transition.emit(self, "Shock")
	
	if direction.is_zero_approx():
		player.velocity.x = move_toward(player.velocity.x, 0, player.HORIZONTAL_SPEED)
		player.velocity.y = move_toward(player.velocity.y, 0, player.VERTICAL_SPEED)
	else:
		# Transition to move walking state
		state_transition.emit(self, "Walk")

func Exit():
	pass
