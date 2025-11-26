# Sam Trout's Love Child

extends CharacterBody2D

# --- Tunable constants ---
@export var accel = 2400
@export var jump_velocity = -400
@export var gravity = 1200
@export var friction = 2000.0
@export var max_speed = 200.0

@export var jump_buffer = 0.1 # seconds
@export var coyote_time = 0.1 # seconds


# --- ability reference ---
var ability_manager: Node = null

@onready var double_jump = $double_jump

# --- Timers ---
var coyote_timer = 0.0
var jump_buffer_timer = 0.0
var bounce_timer := 0.0


# --- Interpolation ---
var last_position: Vector2
var current_position: Vector2
var facing_direction = 1

func _ready():
	last_position = global_position
	current_position = global_position
	
	ability_manager = $AbilityManager
	
	# Delete hashtags to test abilities without grabbing objects
	# ability_manager.unlock("trombone")
	# ability_manager.unlock("cymbals")
	# ability_manager.unlock("tuba")
	

func _physics_process(delta):
	last_position = global_position
	var velocity = self.velocity
	
	#bounce timer
	if bounce_timer > 0:
		bounce_timer -= delta
	else:
		# Gravity
		if not is_on_floor():
			velocity.y += gravity * delta
		else:
			velocity.y = 0
			coyote_timer = coyote_time #grounded, so reset coyote timer

	# Update timers
	if coyote_timer > 0:
		coyote_timer -= delta
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	if self.is_on_wall() and not self.is_on_floor():
		velocity.x = 0;

	# Horizontal movement with acceleration
	var input_dir = Input.get_axis("ui_left", "ui_right")
	if input_dir != 0:
		facing_direction = sign(input_dir)
		velocity.x = move_toward(velocity.x, input_dir * max_speed, accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)


	
	# Jump queue
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer

	# Jump if buffer + coyote overlap
	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = jump_velocity
		jump_buffer_timer = 0
		coyote_timer = 0

	# Variable jump height (short hops)
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5
		
	# Terminal falling speed
	if velocity.y > 400.0:
		velocity.y = 400.0
		
	self.velocity = velocity
  
  # update ability activation
	if ability_manager:
		ability_manager.update_all(self, delta)
	
	$Visual/AnimatedSprite2D.flip_h = facing_direction < 0
	move_and_slide()
	
	current_position = global_position
	
	
	
func _process(delta):
	var alpha = Engine.get_physics_interpolation_fraction()
	var interpolated_pos = last_position.lerp(current_position, alpha)
	$Visual.position = interpolated_pos - global_position
	
func is_dashing() -> bool:
	if ability_manager.get_ability("trombone"):
		return ability_manager.current_ability.isDashing()
	else:
		return false

func is_slamming() -> bool:
	if ability_manager.get_ability("tuba"):
		return ability_manager.current_ability.isSlamming()
	else:
		return false
	
func bounce(bounceHeight: float):
	velocity.y = 0 #This line makes boucning more consistent when slamming, if causing trouble can delete
	if(ability_manager.get_ability("tuba")):  #Allows player to slam again
		ability_manager.current_ability.is_slaming = false
		ability_manager.current_ability.slam_available = true
	velocity.y -= bounceHeight
	bounce_timer = .2
	
