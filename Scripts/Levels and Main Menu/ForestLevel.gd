extends Node2D

@onready var UI = $UILayer/game_ui

@export var bpm: float = 126.0
@onready var camera = $Camera2D

func _ready():
	CheckpointManager.respawn_player()
	camera.matchPositionToPlayer()
	MusicManager.play_track("res://Sound/Music/metForGame25.wav")
	BeatManager.set_bpm(bpm)
	UI.speak([
			{
				"speaker": "Woman",
				"portrait": "forest_neutral",
				"text": "This is the first message. Make sure that the text wraps properly. Press E to go next."
			},
			{
				"speaker": "Woman",
				"portrait": "forest_surprised",
				"text": "This is the second message. Periods and exclamation marks have a slight delay. 67! 67! 67!"
			},
			{
				"speaker": "Woman",
				"portrait": "forest_eyes_closed",
				"text": "This is the last message. If the dialogue box closes without breaking everything, success!"
			},
		]) # Replace with function body.
	
