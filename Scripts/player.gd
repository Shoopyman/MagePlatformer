# Sam Trout's Love Child

extends CharacterBody2D

# --- ability values ---
@export var dash_ability: Node
@export var wall_jump_ability: Node
var abilities = []
var facing_direction = 1

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
	
	# load ability files
	dash_ability = load("res://Scripts/Abilities/dashAbility.gd").new()
	wall_jump_ability = load("res://Scripts/Abilities/wallJumpAbility.gd").new()
	
	abilities = [dash_ability, wall_jump_ability]
	for ability in abilities:
		add_child(ability)

func _physics_process(delta):
	last_position = global_position
	
	# Gravity
	if not is_on_floor():
		if dash_ability == null or not dash_ability.is_dashing:
			self.velocity.y += gravity * delta
	else:
		self.velocity.y = 0
		coyote_timer = coyote_time  # grounded, reset coyote timer

	# Update timers
	if coyote_timer > 0:
		coyote_timer -= delta
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	# Horizontal movement with acceleration
	var input_dir = Input.get_axis("ui_left", "ui_right")
	if input_dir != 0:
		facing_direction = sign(input_dir)
		self.velocity.x = move_toward(self.velocity.x, input_dir * max_speed, accel * delta)
	else:
		self.velocity.x = move_toward(self.velocity.x, 0, friction * delta)

	# Jump queue
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer

	# Jump if buffer + coyote overlap
	if jump_buffer_timer > 0 and coyote_timer > 0:
		self.velocity.y = jump_velocity
		jump_buffer_timer = 0
		coyote_timer = 0

	# Variable jump height (short hops)
	if Input.is_action_just_released("jump") and self.velocity.y < 0:
		self.velocity.y *= 0.5

	# update ability activation
	for ability in abilities:
		ability.update(self, delta)
		#this calls the update function in the ability file
	
	move_and_slide()

	current_position = global_position

func _process(delta):
	var alpha = Engine.get_physics_interpolation_fraction()
	global_position = last_position.lerp(current_position, alpha)
