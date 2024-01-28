extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

@onready var EntityContainer = $".."

@export var HORIZONTAL_SPEED = 100.0
@export var VERTICAL_SPEED = 80.0
@export var SPRINT_MULTIPLIER = 3.0

@export var pie_projectile: PackedScene

var screen_size

# Player Action States
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


func _physics_process(_delta):
	# Get input if we are in IDLE or WALK state
	if current_state == PlayerState.IDLE or current_state == PlayerState.WALK:
		var horizontal_direction = Input.get_axis("walk_left", "walk_right")
		if horizontal_direction:
			velocity.x = horizontal_direction * HORIZONTAL_SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, HORIZONTAL_SPEED)

		var vertical_direction = Input.get_axis("walk_up", "walk_down")
		if vertical_direction:
			velocity.y = vertical_direction * VERTICAL_SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, VERTICAL_SPEED)
	# Otherwise no movement
	else:
		velocity.x = move_toward(velocity.x, 0, HORIZONTAL_SPEED)
		velocity.y = move_toward(velocity.y, 0, VERTICAL_SPEED)

	# Idle <-> Walk state check
	if current_state != PlayerState.PIE:
		if velocity.is_zero_approx():
			set_state(PlayerState.IDLE)
		else:
			set_state(PlayerState.WALK)
	# Sprite flip check
	if velocity.x < 0 && not velocity.is_zero_approx():
		animated_sprite.flip_h = true
	elif velocity.x > 0 && not velocity.is_zero_approx():
		animated_sprite.flip_h = false
	
	# Play current state animation
	match current_state:
		PlayerState.IDLE:
			animated_sprite.play("Idle")
		PlayerState.WALK:
			animated_sprite.play("Walk")
		PlayerState.PIE:
			animated_sprite.play("Pie Throw")

	# Move and adjust postion
	move_and_slide()
	position = position.clamp(Vector2.ZERO, screen_size)


# Ugly animation state machine right here
func _on_animated_sprite_2d_animation_finished():
	# Unlock other animations if action just finished
	if animated_sprite.animation == "Pie Throw":
		set_state(PlayerState.IDLE)
		var pie = pie_projectile.instantiate()
		owner.add_child(pie)
		pie.position = $PieSpawnPoint.global_position
		print("Throwing pie left: ", animated_sprite.flip_h)
		pie.throw(animated_sprite.flip_h)
