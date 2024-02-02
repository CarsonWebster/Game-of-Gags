extends CharacterBody2D


@export var HORIZONTAL_SPEED = 5000.0
@export var VERTICAL_SPEED = 3000.0

func _physics_process(_delta):
	move_and_slide()
