extends Node

signal beat
signal half_beat

# Set based on your song BPM
var bpm: float = 120
var seconds_per_beat: float

func _ready():
	seconds_per_beat = 60.0 / bpm
	beat_timer()

func beat_timer():
	emit_signal("beat")
	await get_tree().create_timer(seconds_per_beat / 2.0).timeout
	emit_signal("half_beat")
	await get_tree().create_timer(seconds_per_beat / 2.0).timeout
	beat_timer() # loops forever
