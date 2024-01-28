extends Area2D

const SPEED = 40.0
var direction_vector: Vector2 = Vector2(1, 0)
	
func _physics_process(delta):
	position += direction_vector * SPEED * delta
	
func set_direction(v: Vector2):
	direction_vector = v
