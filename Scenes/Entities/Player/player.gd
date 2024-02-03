extends CharacterBody2D

@export var HORIZONTAL_SPEED = 5000.0
@export var VERTICAL_SPEED = 3000.0

@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var state_machine: Node = %StateMachine

func _ready():
	pass

func _physics_process(_delta):
	move_and_slide()

func do_movement(_delta: float):
	var direction: Vector2 = Vector2(Input.get_axis("walk_left", "walk_right"), Input.get_axis("walk_up", "walk_down"))
	if direction.x:
		velocity.x = direction.x * HORIZONTAL_SPEED * _delta
	else:
		velocity.x = move_toward(velocity.x, 0, HORIZONTAL_SPEED)
	if direction.y:
		velocity.y = direction.y * VERTICAL_SPEED * _delta
	else:
		velocity.y = move_toward(velocity.y, 0, VERTICAL_SPEED)
	
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true

func check_attacks(caller_state: State):
	if Input.is_action_just_released("attack1"):
		# Transition to banana drop
		state_machine.current_state.state_transition.emit(caller_state, "BananaDrop")
	if Input.is_action_pressed("attack1"):
		# Switch to banana walk
		state_machine.current_state.state_transition.emit(caller_state, "BananaWalk")
	if Input.is_action_just_released("attack2"):
		# Transition to pie throw
		state_machine.current_state.state_transition.emit(caller_state, "PieThrow")
	if Input.is_action_pressed("attack2"):
		# Switch to banana walk
		state_machine.current_state.state_transition.emit(caller_state, "PieWalk")
	if Input.is_action_just_released("attack3"):
		# Transition to shock
		state_machine.current_state.state_transition.emit(caller_state, "ShockMiss")
