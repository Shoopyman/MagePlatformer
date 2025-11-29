extends Node2D

# --- Nodes ---
@onready var bodyAnimation = $AnimatedSprite2D
@onready var leftHand = $"Left hand"
@onready var rightHand = $"Right Hand"
@onready var trackPlayer = $TrackPlayer

# --- Config ---
@export var leftHandSpeed = 100
@export var rightHandSpeed = 100
@export var handSwipeInterval = 5.0  # seconds
@export var beam_scene: PackedScene

# --- State ---
var leftHandDirection = 1
var rightHandDirection = -1
var handToAttack = randi_range(0,1) # 0 = left, 1 = right
var elapsedTime = 0.0
var is_hand_busy = false
var player: Node2D = null
var player_position: Vector2 = Vector2.ZERO
var spawned = false

enum handState {
	LeftHandAttack,
	LeftHandIdle,
	RightHandAttack,
	RightHandIdle
}

var currentStateLeft = handState.LeftHandIdle
var currentStateRight = handState.RightHandIdle

# --- Signals from walls ---
func _on_left_wall_body_entered(body: Node2D) -> void:
	if body.is_in_group("leftHand"):
		changeStateLeft(handState.LeftHandIdle)
	elif body.is_in_group("rightHand"):
		changeStateRight(handState.RightHandIdle)

# --- Signals from hands hitting player ---
func _on_left_hand_body_entered(body: Node2D) -> void:
	pass
	#if body.is_in_group("player"):
		#CheckpointManager.load_saved_progression()

func _on_right_hand_body_entered(body: Node2D) -> void:
	pass
	#if body.is_in_group("player"):
		#CheckpointManager.load_saved_progression()

# --- Track player ---
func _on_track_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body

# --- Physics loop ---
func _physics_process(delta: float) -> void:
	if player:
		player_position = player.global_position
		elapsedTime += delta
		if elapsedTime >= handSwipeInterval and not is_hand_busy:
			is_hand_busy = true
			elapsedTime = 0
			if(handToAttack == 0):
				changeStateLeft(handState.LeftHandAttack)
				beamAttack(leftHand)
			else:
				changeStateLeft(handState.LeftHandAttack)
				beamAttack(rightHand)
			handToAttack = randi_range(0,1)

# --- Hand states ---
func changeStateLeft(newState: handState):
	currentStateLeft = newState
	match currentStateLeft:
		handState.LeftHandAttack:
			pass # Play attack animation
		handState.LeftHandIdle:
			pass # Play idle animation

func changeStateRight(newState: handState):
	currentStateRight = newState
	match currentStateRight:
		handState.RightHandAttack:
			pass # Play attack animation
		handState.RightHandIdle:
			pass # Play idle animation

func beamAttack(hand: Area2D):
	if not is_inside_tree():
		return
		
	var timer = 0
	
	while timer < 3.0:
		
		var d = get_process_delta_time()
		timer +=d
		
		if player != null:
			
			hand.global_position.y = move_toward_float(hand.global_position.y, player_position.y, leftHandSpeed * d)
			
		await get_tree().create_timer(0).timeout
		
	var beam = beam_scene.instantiate()
	
	if not spawned:
		
		get_tree().current_scene.add_child(beam)
		beam.global_position = hand.global_position
		spawned = true
		
	var timer2 = 0
	
	while timer2 < 5.0:
		
		var d = get_process_delta_time()
		timer2 +=d
		await get_tree().create_timer(0).timeout
		spawned = false
	beam.queue_free()
	is_hand_busy = false
	changeStateLeft(handState.LeftHandIdle)
	changeStateRight(handState.RightHandIdle)
	leftHand.position.y = -153
	rightHand.position.y = -153

#Helper function for one above
func move_toward_float(current: float, target: float, max_delta: float) -> float:
	var delta = target - current
	if abs(delta) <= max_delta:
		return target
	return current + sign(delta) * max_delta


func _on_track_player_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
