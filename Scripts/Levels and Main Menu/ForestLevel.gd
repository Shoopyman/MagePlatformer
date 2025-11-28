extends Node2D

@onready var UI = $UILayer/game_ui

@export var bpm: float = 126.0
@onready var camera = $Camera2D

func _ready():
	CheckpointManager.respawn_player()
	camera.matchPositionToPlayer()
	MusicManager.play_track("res://Sound/Music/metForGame25.wav")
	BeatManager.set_bpm(bpm)
	
