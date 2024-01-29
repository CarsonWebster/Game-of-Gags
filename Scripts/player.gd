extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var player_stats = $"../../ManagerContainer/PlayerStatHandler"
@onready var EntityContainer = $".."

@export var HORIZONTAL_SPEED = 100.0
@export var VERTICAL_SPEED = 80.0
@export var SPRINT_MULTIPLIER = 3.0

@export var pie_projectile: PackedScene
@export var banana_trap: PackedScene

var screen_size

# Player Action States
enum PlayerState {
	IDLE,
	WALK,
	PIE_WALK,
	PIE,
	BANANA_WALK,
	BANANA,
	SHOCK,
	BANANA_IDLE,
	PIE_IDLE,
}
var MoveableStates: Array[PlayerState] = [PlayerState.IDLE, PlayerState.WALK, PlayerState.BANANA_WALK, PlayerState.PIE_WALK,PlayerState.PIE_IDLE, PlayerState.BANANA_IDLE]
var NonMoveableStates: Array[PlayerState] = [PlayerState.PIE, PlayerState.BANANA, PlayerState.SHOCK]

var current_state: PlayerState
func set_state(new_state: PlayerState):
	if current_state != new_state:
		current_state = new_state
		#print(current_state)

func _ready():
	screen_size = get_viewport_rect().size
	current_state = PlayerState.IDLE
	
func _process(_delta):
	if Input.is_action_pressed("attack1") and player_stats.current_bananas > 0:
		set_state(PlayerState.BANANA_WALK)
	if Input.is_action_just_released("attack1") and player_stats.current_bananas > 0:
		set_state(PlayerState.BANANA)
		drop_banana()
	if Input.is_action_pressed("attack2") and player_stats.current_pies > 0:
		set_state(PlayerState.PIE_WALK)
	if Input.is_action_just_released("attack2") and player_stats.current_pies > 0:
		set_state(PlayerState.PIE)
	if Input.is_action_pressed("attack3") and player_stats.current_shocks > 0:
		set_state(PlayerState.SHOCK)


func _physics_process(_delta):
	# Get input if we are in IDLE or WALK state
	if current_state in MoveableStates:
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
	if current_state in MoveableStates:
		if velocity.is_zero_approx():
			#print("IDLING")
			match current_state:
				PlayerState.BANANA_WALK:
					set_state(PlayerState.BANANA_IDLE)
				PlayerState.PIE_WALK:
					set_state(PlayerState.PIE_IDLE)
				_:
					set_state(PlayerState.IDLE)
		elif current_state == PlayerState.IDLE:
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
			if not $Walk.playing:
				$Walk.play()
		PlayerState.BANANA_WALK:
			animated_sprite.play("Banana Walk")
			if not $BananaWalk.playing:
				$BananaWalk.play()
		PlayerState.PIE_WALK:
			animated_sprite.play("Pie Walk")
		PlayerState.PIE:
			animated_sprite.play("Pie Throw")
		PlayerState.BANANA:
			animated_sprite.play("Banana Drop")
		PlayerState.SHOCK:
			animated_sprite.play("Handshake Miss")
			if not $Zap.playing:
				$Zap.play()
		PlayerState.PIE_IDLE:
			animated_sprite.play("Pie Idle")
		PlayerState.BANANA_IDLE:
			animated_sprite.play("Banana Idle")

	# Move and adjust postion
	move_and_slide()
	position = position.clamp(Vector2(0, 100), screen_size)


# Ugly animation state machine right here
func _on_animated_sprite_2d_animation_finished():
	# Unlock other animations if action just finished
	#print("Animation finsihed: ", animated_sprite.animation)
	match animated_sprite.animation:
		"Pie Throw":
			set_state(PlayerState.IDLE)
			throw_pie()
		"Banana Drop":
			set_state(PlayerState.IDLE)
			drop_banana()
		_:
			set_state(PlayerState.IDLE)

func throw_pie():
	if player_stats.current_pies > 0:
		player_stats.on_pie_dropped()
		var pie = pie_projectile.instantiate()
		owner.add_child(pie)
		pie.position = $PieSpawnPoint.global_position
		pie.throw(animated_sprite.flip_h)
		if not $PieThrow.playing:
				$PieThrow.play()

func drop_banana():
	if player_stats.current_bananas > 0:
		#print("banana")
		player_stats.on_banana_dropped()
		var banana = banana_trap.instantiate()
		owner.add_child(banana)
		banana.position = $BananaSpawnPoint.global_position
		if not $BananaDrop.playing:
			$BananaDrop.play()
