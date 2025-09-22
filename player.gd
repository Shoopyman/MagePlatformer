#Sam Trout's Love Child

extends CharacterBody2D


#list of constants that I can change easily for tuning
@export var accel = 2400
@export var jump_velocity = -400
@export var gravity = 1200
@export var friction = 1500.0
@export var max_speed = 200.0
@export var jump_buffer = 0.1 #seconds
@export var coyote_time = 0.1 #seconds

var coyote_timer = 0.0
var jump_buffer_timer = 0.0

func _physics_process(delta):
	var velocity = self.velocity

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		coyote_timer = coyote_time #grounded, so reset coyote timer


	#update timers
	if coyote_timer > 0:
		coyote_timer -= delta
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta
	
	
	# horizontal movement with acceleration
	var input_dir = Input.get_axis("ui_left", "ui_right")

	if input_dir != 0:
		velocity.x = move_toward(velocity.x, input_dir * max_speed, accel * delta)
	else:
		# friction when no input (slow down precise landings)
		velocity.x = move_toward(velocity.x, 0, friction * delta)


	#jump queue
	if Input.is_action_just_pressed("ui_accept"):
		jump_buffer_timer = jump_buffer #set the timer to land within the buffer
	
	# Jump if coyote and buffer
	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = jump_velocity
		#reset the clocks
		#if i dont do this, then you could do two jumps instantly and gain huge verticality
		#i actually remember playing red ball 3, where they did let you do this.
		jump_buffer_timer = 0
		coyote_timer = 0

	#jump height
	if Input.is_action_just_released("ui_accept") and velocity.y < 0:
		velocity.y *= 0.5   # if jump released, slow down (short hops)

	self.velocity = velocity
	move_and_slide()
	
	
