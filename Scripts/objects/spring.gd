extends Area2D

# constant values
@export var bounceHeight := 600
@export var beats_between_bounce := 4


# Nodes
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# variables
enum State { WAITING, RISING }
var state: State = State.WAITING
var objectInArea := false
var current_body: Node = null
var beat_counter := -1

func _ready():
	BeatManager.beat.connect(_on_beat)
	sprite.play("Idle")

func _physics_process(_delta):
	match state:
		State.WAITING:
			sprite.play("Idle")
		State.RISING:
			sprite.play("Action")


func _on_body_entered(body: Node2D) -> void:
	objectInArea = true
	current_body = body


func _on_body_exited(_body: Node2D) -> void:
	objectInArea = false
	current_body = null


func _on_beat() -> void:
	if int(floor(BeatManager.get_level_beat())) % 4 == 0:
		# trigger spring on downbeat
		_activate_spring()


# -----------------------------------------
# Internal animation + bounce sequence
# -----------------------------------------
func _activate_spring() -> void:
	state = State.RISING
	sprite.play("Action")

	# small delay before bounce happens
	await get_tree().create_timer(0.08).timeout  # THIS LINE CRASGES GAME

	# bounce if object is on the spring
	if objectInArea and current_body and current_body.has_method("bounce"):
		current_body.bounce(bounceHeight)

	# wait for animation to finish
	await get_tree().create_timer(0.16).timeout

	state = State.WAITING
	sprite.play("Idle")
