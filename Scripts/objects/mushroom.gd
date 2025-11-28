extends CharacterBody2D

#Constant variables
@export_enum("red", "brown") var color := "red"
@export var bounceHeightTuba = 1250
@export var smallHeight = 450
@export var walkSpeed = 50
@export var direction = 1
@export var accel = 2400


# Nodes
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


# variables
enum State {WALKING, STUNNED}
var defaultState: State = State.WALKING

func _ready():
	changeState(defaultState)
	# Setup Timer

func _physics_process(delta): 
	velocity.y = 0
	
	if direction == -1:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
		
	match defaultState:
		State.WALKING:
			velocity.x = move_toward(velocity.x, direction * walkSpeed, accel * delta)
		State.STUNNED:
			velocity.x = 0
	move_and_slide()
	if(is_on_wall()):
		direction *= -1

func changeState(newState: State):
	defaultState = newState
	sprite.stop()
	sprite.frame = 0
	match defaultState:
		State.WALKING:
			sprite.play(color + "Walking")
		State.STUNNED:
			sprite.play(color + "Bouncing")

#checks if 
func _on_area_2d_body_entered(body: Node2D) -> void:
	CheckpointManager.load_saved_progression()


func _on_bounce_body_entered(body: Node2D) -> void:
	
	changeState(State.STUNNED)
	if(body.is_slamming()):
		print("Player Bounced")
		body.bounce(bounceHeightTuba)
	else:
		body.bounce(smallHeight)


func _on_animated_sprite_2d_animation_finished() -> void:
	changeState(State.WALKING)
