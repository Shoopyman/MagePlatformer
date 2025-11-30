extends Node2D

@onready var UI = $UILayer/game_ui

@export var bpm: float = 76.0
@onready var camera = $Camera2D

func _ready():
	CheckpointManager.respawn_player()
	camera.matchPositionToPlayer()
	MusicManager.play_track("res://Sound/Music/ForestMusic.mp3")
	BeatManager.set_bpm(bpm)
	
