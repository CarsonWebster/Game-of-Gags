extends StaticBody2D

@export var SPEED = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2()
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_down", "ui_up")
	
	transform.x = transform.x + direction.x * SPEED * delta
	transform.y = transform.y + direction.y * SPEED * delta
