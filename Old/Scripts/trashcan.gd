extends RigidBody2D

@onready var banana_timer: Timer = $BananaTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


@export var banana_collectable: PackedScene
@export var bananares: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	banana_timer.wait_time = randi_range(10, 30)


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "Spawn":
		animated_sprite.play("Idle")

func _on_banana_timer_timeout():
	animated_sprite.play("Spawn")
	$SpawnSound.play()
	var banana = banana_collectable.instantiate()
	banana.collectable_resource = bananares
	$"../../EntityContainer".add_child(banana)
	banana.position = global_position
	banana.position += Vector2(randi_range(-10,10), randi_range(-10,10))
