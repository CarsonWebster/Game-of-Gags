extends State
class_name PlayerShockMiss

var player : CharacterBody2D
@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	sprite.play("Shock Miss")

func Exit():
	pass

func Update(_delta:float):
	pass

func Physics_Update(_delta: float):
	player.velocity.x = move_toward(player.velocity.x, 0, player.HORIZONTAL_SPEED)
	player.velocity.y = move_toward(player.velocity.y, 0, player.VERTICAL_SPEED)

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "Shock Miss":
		state_transition.emit(self, "Idle")
