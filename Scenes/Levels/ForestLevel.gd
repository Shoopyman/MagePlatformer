extends Node2D


@export var bpm: float = 126.0
@onready var camera = $Camera2D

<<<<<<< HEAD
@onready var testDialogue = $Camera2D/dialogue1

func _ready()->void:
	
	# Set BPM before starting
	BeatManager.set_bpm(bpm)

	# Start beat tracking at exactly the same audio frame
	BeatManager.reset_beat_timer()

	# Start the music
	music_player.play()




func _on_test_sign_body_entered(body: Node2D) -> void:
	if testDialogue.visible == false:
		testDialogue.start_dialogue([
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
=======
func _ready():
	CheckpointManager.respawn_player()
	camera.matchPositionToPlayer()
	MusicManager.play_track("res://Sound/Music/metForGame25.wav")
	BeatManager.set_bpm(bpm)
>>>>>>> 95cd9ceab6e75e56d16c068e1cf0beff20c5f96d
