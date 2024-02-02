extends RigidBody2D

enum Heading {
	NORTH,
	SOUTH,
	EAST,
	WEST
}

var current_heading: Heading = Heading.EAST
var velocity: Vector2

@export var SPEED: float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready():
	#print("Victim spawned at: ", get_global_position())
	if position.x < 0:
		current_heading = Heading.EAST
	else:
		current_heading = Heading.WEST
	#print("Current heading: ", current_heading)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_heading:
		Heading.WEST:
			position.x += SPEED * delta
		Heading.EAST:
			position.x -= SPEED * delta
