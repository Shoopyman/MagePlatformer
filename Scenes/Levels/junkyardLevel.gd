extends Node2D

@export var bpm: int = 126
@onready var music_player: AudioStreamPlayer = $"Sounds and Music/MusicPlayer"

func _ready():
	# Set BPM before starting
	BeatManager.set_bpm(bpm)

	# Start beat tracking at exactly the same audio frame
	BeatManager.reset_beat_timer()

	# Start the music
	music_player.play()
