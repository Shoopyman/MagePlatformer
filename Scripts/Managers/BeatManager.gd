extends Node

signal beat
signal half_beat

var bpm: float = 120
var seconds_per_beat: float

var timer := 0.0
var half_beat_fired := false

func _ready():
	set_bpm(bpm)

func set_bpm(new_bpm: float) -> void:
	bpm = new_bpm
	seconds_per_beat = 60.0 / bpm

func reset_beat_timer() -> void:
	timer = 0.0
	half_beat_fired = false

func _process(delta: float) -> void:
	timer += delta

	# Half-beat at exactly 50% point
	if not half_beat_fired and timer >= seconds_per_beat * 0.5:
		half_beat_fired = true
		emit_signal("half_beat")

	# Full beat
	if timer >= seconds_per_beat:
		timer -= seconds_per_beat
		half_beat_fired = false
		emit_signal("beat")
