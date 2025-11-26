extends Node2D


@export var bpm: int = 126
@onready var music_player: AudioStreamPlayer = $"MusicPlayer"

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
