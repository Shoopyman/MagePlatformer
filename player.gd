extends CharacterBody2D

@export var speed = 200
@export var jump_velocity = -400
@export var gravity = 1200

func _physics_process(delta):
	var velocity = self.velocity
	
	#gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		velocity.y = 0
		
	#horizontal movement
	var input_dir = Input.get_axis("ui_left", "ui_right")
	velocity.x = input_dir * speed
	
	#jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		
	self.velocity = velocity
	move_and_slide()
