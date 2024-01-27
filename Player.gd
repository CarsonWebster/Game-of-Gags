extends Node2D

var screen_size
@export var SPEED = 400
@onready var _animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2()
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	if direction.is_zero_approx():
		_animated_sprite.play("Idle")
	else:
		_animated_sprite.play("Walk")
		if direction.x < 0:
			if _animated_sprite.flip_h == false:
				_animated_sprite.flip_h = true
		else:
			if _animated_sprite.flip_h == true:
				_animated_sprite.flip_h = false
	
	position += + direction * SPEED * delta
	position = position.clamp(Vector2.ZERO, screen_size)

