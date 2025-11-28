extends Area2D

# constant values
@export var bounceHeight := 800
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


func _activate_spring() -> void:
	state = State.RISING
	sprite.play("Action")

func spring_bounce() -> void:
	if objectInArea and current_body and is_instance_valid(current_body):
		if current_body.has_method("bounce"):
			current_body.bounce(bounceHeight)

func spring_reset() -> void:
	state = State.WAITING
	sprite.play("Idle")
