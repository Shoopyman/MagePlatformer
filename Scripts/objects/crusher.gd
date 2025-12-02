extends CharacterBody2D

# ---- Exported variables ----
@export var fall_speed := 600.0
@export var rise_speed := 200.0
@export var wait_time := 1.0
@export var cycle_time := 5.0

# ---- Node references ----
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area: Area2D = $Area2D
@onready var timer: Timer = $Timer

# ---- State machine ----
enum State { WAITING, FALLING, RISING }
var state: State = State.WAITING
var start_position: Vector2

func _ready():
	start_position = global_position
	BeatManager.beat.connect(_on_beat)

func _on_beat() -> void:
	if int(floor(BeatManager.get_level_beat())) % 4 == 0:
		activate_crusher()

func _physics_process(delta):
	velocity.x = 0
	match state:
		State.FALLING:
			velocity.y = fall_speed
			move_and_slide()
			if is_on_floor():
				velocity.y = 0
				state = State.WAITING

		State.RISING:
			# move up manually, ignoring collisions
			global_position.y -= rise_speed * delta
			if global_position.y <= start_position.y:
				global_position.y = start_position.y
				state = State.WAITING

		State.WAITING:
			velocity.y = 0

func activate_crusher():
	if state == State.WAITING:
		if global_position.y <= start_position.y + 1:
			state = State.FALLING
		else:
			state = State.RISING

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("player"):
		CheckpointManager.load_saved_progression()
