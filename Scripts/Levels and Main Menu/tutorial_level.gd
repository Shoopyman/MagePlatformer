extends Node2D

@onready var sign1 = $"Basic Control Sign/Label"
@onready var player = $Player
@onready var moveTest = $MoveText
@onready var camera = $Camera2D
@onready var sign2 = $Sign
@onready var sign3 = $Sign2
var bpm = 126

var firstLoad = true

var moveTextDeleted = false

func _ready()->void:
	CheckpointManager.respawn_player()
	sign1.text = "To jump Press C\n"
	sign2.text = "Press C again while in air to double jump"
	sign3.text = "Press C while facing wall to jump off the wall"
	MusicManager.play_track("res://Sound/Music/metForGame25.wav")
	BeatManager.set_bpm(bpm)
	var spb = 60.0 / bpm
	var t = MusicManager.player.get_playback_position()
	BeatManager.beat_offset = ceil(t / spb) - (t / spb)
	camera.follow_mode = "FULL_FOLLOW"
	CheckpointManager.respawn_player()
	


func _on_despawn_sign_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if(body.is_in_group('player') && moveTextDeleted == false):
		moveTest.queue_free()
		moveTextDeleted = true
