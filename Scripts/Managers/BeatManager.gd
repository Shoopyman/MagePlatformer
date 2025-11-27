extends Node

signal beat()        # full beat (1, 2, 3, 4)
signal half_beat()   # halfway between beats (1.5, 2.5, 3.5)

var bpm: float = 120.0
var last_beat_index := -1     # last full beat emitted
var last_half_index := -1     # last half beat emitted
var beat_offset := 0.0

func set_bpm(new_bpm: float) -> void:
	bpm = new_bpm
	# Do NOT reset beat indices. We want to continue syncing with the music.

func get_level_beat() -> float:
	return get_beat_position() + beat_offset

func get_beat_position() -> float:
	var spb = 60.0 / bpm  # seconds per beat
	var t = MusicManager.player.get_playback_position()
	return t / spb        # beat count as a float

func _process(_delta) -> void:
	var beat_pos = get_beat_position()
	
	# full beat index (0,1,2,3,...)
	var beat_index = int(floor(beat_pos))

	# half beat index (0,1,2,3,... for each 0.5)
	var half_index = int(floor(beat_pos * 2.0))

	# Emit full beat when crossing into next beat
	if beat_index != last_beat_index:
		last_beat_index = beat_index
		emit_signal("beat")

	# Emit half beat
	if half_index != last_half_index:
		last_half_index = half_index
		emit_signal("half_beat")
