extends CharacterBody2D

#Constant variables
@export var bounceHeight = 1000
@export var walkSpeed = 100
@export var direction = 1
@export var accel = 2400

# Nodes
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


# variables
enum State {WALKING, STUNNED}
var defualtState: State = State.WALKING
var current_body: Node = null


func _ready():
	pass
	# Setup Timer
	
		
func _physics_process(delta): 
	velocity.y = 0
	match defualtState:
		State.WALKING:
			velocity.x = move_toward(velocity.x, direction * walkSpeed, accel * delta)
	move_and_slide()
	if(is_on_wall()):
		direction *= -1
	

func changeState(newState: State):
	defualtState = newState
	match defualtState:
		State.WALKING:
			sprite.play("Walking")
		State.STUNNED:
			sprite.play("Bouncing")
			calcluateBounce(current_body)

#checks if 
func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
	#if(body.is_in_group("player")):
		#CheckpointManager.load_saved_progression()
		
func calcluateBounce(body: Node2D):
	print("Making Player bounce")
	current_body.bounce(bounceHeight)
	changeState(State.WALKING)
	


func _on_bounce_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player") && body.is_slamming()):
		print("Player Bounced")
		current_body = body
		changeState(State.STUNNED)
		walkSpeed = 0
	elif (body.is_in_group("player") && body.is_slamming() == false):
		CheckpointManager.load_saved_progression()


func _on_bounce_body_exited(body: Node2D) -> void:
	walkSpeed = 100 
