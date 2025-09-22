# Sam Trout's Love Child

extends CharacterBody2D

# --- Tunable constants ---
@export var accel = 2400
@export var jump_velocity = -400
@export var gravity = 1200
@export var friction = 1500.0
@export var max_speed = 200.0
@export var jump_buffer = 0.1 # seconds
@export var coyote_time = 0.1 # seconds

# --- Timers ---
var coyote_timer = 0.0
var jump_buffer_timer = 0.0

# --- Interpolation ---
var last_position: Vector2
var current_position: Vector2

func _ready():
	last_position = global_position
	current_position = global_position

func _physics_process(delta):
	last_position = global_position

	var velocity = self.velocity

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		coyote_timer = coyote_time  # grounded, reset coyote timer

	# Update timers
	if coyote_timer > 0:
		coyote_timer -= delta
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	# Horizontal movement with acceleration
	var input_dir = Input.get_axis("ui_left", "ui_right")
	if input_dir != 0:
		velocity.x = move_toward(velocity.x, input_dir * max_speed, accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	# Jump queue
	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer_timer = jump_buffer

	# Jump if buffer + coyote overlap
	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = jump_velocity
		jump_buffer_timer = 0
		coyote_timer = 0

	# Variable jump height (short hops)
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= 0.5

	self.velocity = velocity
	move_and_slide()

	current_position = global_position

func _process(delta):
	var alpha = Engine.get_physics_interpolation_fraction()
	global_position = last_position.lerp(current_position, alpha)
