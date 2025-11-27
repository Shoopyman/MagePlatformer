extends Node2D

@export var bpm: float = 126.0

@onready var player = $Player
@onready var camera = $Camera2D
@onready var timer = $Timer
@onready var test = $TestTimer
@onready var warp2 = $Warps/Warp2/CollisionShape2D
@onready var movingPlatform = $movingPlatform2

var timeLeft = 30
var inBox = false

func _ready() -> void:
	CheckpointManager.respawn_player()
	camera.matchPositionToPlayer()
	MusicManager.play_track("res://Sound/Music/metForGame25.wav")
	BeatManager.set_bpm(bpm)
	


func _physics_process(delta: float) -> void:
	if(inBox):
		test.text = "Time Left: %.0f" % timeLeft
		timeLeft -= delta
	if(TheaterManager.platformEnabled):
		movingPlatform.process_mode = Node.PROCESS_MODE_INHERIT
		movingPlatform.set_physics_process(true)
		movingPlatform.set_process(true)
	else:
		movingPlatform.process_mode = Node.PROCESS_MODE_DISABLED
		movingPlatform.set_physics_process(false)
		movingPlatform.set_process(false)
		

func _on_warp_1_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player.global_position.x = 1259 
		player.global_position.y = -2266
		timer.start()
		inBox = true
		#Get rid of player ability


func _on_timer_timeout() -> void:
	TheaterManager.phase += 1
	if TheaterManager.phase == 0:
		player.global_position.x = 3801
		player.global_position.y = -24
	elif TheaterManager.phase == 1:
		player.global_position.x = 5786
		player.global_position.y = -126
		TheaterManager.platformEnabled = true
		


func _on_bug_test_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player.global_position.x = 5786
		player.global_position.y = -126 
		TheaterManager.platformEnabled = true


func _on_warp_2_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player.global_position.x = 1259 
		player.global_position.y = -2266
		timer.start()
		inBox = true 
		warp2.set_deferred("disabled", true)
		


func _on_warp_3_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player.global_position.x = 5786
		player.global_position.y = -126 
