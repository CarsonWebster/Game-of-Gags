extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

@export var SPEED: float = 200.0
@export var FALLING_SPEED: float = 20
@export var RANGE: float = 20.0
#@export var ACCELERATION = 10.0
var start_y: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sprite.flip_v:
		position.x -= SPEED * delta
	else:
		position.x += SPEED * delta
	position.y += FALLING_SPEED * delta
	print("Y pos: ", position.y, "difference: ", start_y - position.y)
	if (position.y - start_y ) > RANGE:
		queue_free()

func throw(moving_left: bool):
	sprite.flip_v = moving_left
	start_y = position.y
	print("Starting y: ", start_y)
