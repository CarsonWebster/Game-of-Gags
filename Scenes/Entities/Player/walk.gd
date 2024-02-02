extends State
class_name PlayerWalk

var player : CharacterBody2D
@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	sprite.play("Walk")

func Exit():
	pass

func Physics_Update(_delta:float):
	# Player movement calculations
	var direction: Vector2 = Vector2(Input.get_axis("walk_left", "walk_right"), Input.get_axis("walk_up", "walk_down"))
	if direction.x:
		player.velocity.x = direction.x * player.HORIZONTAL_SPEED * _delta
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.HORIZONTAL_SPEED)
	if direction.y:
		player.velocity.y = direction.y * player.VERTICAL_SPEED * _delta
	else:
		player.velocity.y = move_toward(player.velocity.y, 0, player.VERTICAL_SPEED)
	
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	
	if player.velocity.is_zero_approx():
		state_transition.emit(self, "Idle")
