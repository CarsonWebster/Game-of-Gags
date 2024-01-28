extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@export var SPEED = 100.0

var screen_size

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


enum PlayerState {
	IDLE,
	WALK,
	PIE,
}
var current_state: PlayerState
func set_state(new_state: PlayerState):
	if current_state != new_state:
		current_state = new_state

func _ready():
	screen_size = get_viewport_rect().size
	current_state = PlayerState.IDLE
	
func _process(_delta):
	if Input.is_action_just_pressed("attack2"):
		set_state(PlayerState.PIE)
	
	#print("State: ", current_state)
		

func _physics_process(_delta):
	if current_state == PlayerState.IDLE or current_state == PlayerState.WALK:
		var horizontal_direction = Input.get_axis("walk_left", "walk_right")
		if horizontal_direction:
			velocity.x = horizontal_direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		var vertical_direction = Input.get_axis("walk_up", "walk_down")
		if vertical_direction:
			velocity.y = vertical_direction * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if current_state != PlayerState.PIE:
		if velocity.is_zero_approx(): 
			set_state(PlayerState.IDLE)
		else:
			set_state(PlayerState.WALK)
	
	if velocity.x < 0 && not velocity.is_zero_approx():
		animated_sprite.flip_h = true
	elif velocity.x > 0 && not velocity.is_zero_approx():
		animated_sprite.flip_h = false
	
	match current_state:
		PlayerState.IDLE:
			animated_sprite.play("Idle")
		PlayerState.WALK:
			animated_sprite.play("Walk")
		PlayerState.PIE:
			animated_sprite.play("Pie Throw")

	move_and_slide()
	position = position.clamp(Vector2.ZERO, screen_size)



func _on_animated_sprite_2d_animation_changed():
	#print("Animation changed!: ", animated_sprite.animation)
	pass


func _on_animated_sprite_2d_animation_finished():
	#print("An animation finished!: ", animated_sprite.animation)
	if animated_sprite.animation == "Pie Throw":
		set_state(PlayerState.IDLE)
