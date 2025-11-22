extends Area2D

# constant values
@export var bounceHeight = 600
@export var wait_time := 3.0 # Time Until Spring activates after cycle complete

# Nodes
@onready var timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# variables
enum State { WAITING, RISING}
var state: State = State.WAITING
var objectInArea = false
var current_body: Node = null

func _ready():
	
	# Setup Timer
	timer.wait_time = wait_time
	timer.start()
	sprite.play("Idle")
		
func _physics_process(delta):
	match state:
		State.WAITING:
			sprite.play("Idle")
		State.RISING:
			sprite.play("Action")
			
func _on_body_entered(body: Node2D) -> void:
	objectInArea = true
	current_body = body


func _on_body_exited(body: Node2D) -> void:
	objectInArea = false
	current_body = null


func _on_timer_timeout() -> void:
	if state == State.WAITING:
		#Set state to Rising
		state = State.RISING
		sprite.play("Action")
		
		#Allow for Animation time to begin playing
		await get_tree().create_timer(0.2).timeout
		
		#Makes sure body on spring can bounce.
		if objectInArea and current_body and current_body.has_method("bounce"):
			print("Spring activating!")
			current_body.bounce(bounceHeight)
		
		#Allows time for animation to finish
		await get_tree().create_timer(.9).timeout
		
		state = State.WAITING
		sprite.play("Idle")
		
		#Reset timer
		timer.start()
