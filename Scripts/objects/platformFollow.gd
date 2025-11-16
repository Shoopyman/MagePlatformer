extends PathFollow2D

@export var speed_per_beat: float = 0.1    # how far to move each beat
@export var travel_speed: float = 6.0      # how fast to lerp to target

var target_progress := 0.0

func _ready():
	BeatManager.beat.connect(_on_beat)

func _process(delta):
	# Smooth movement toward target
	# Using lerp_angle-like logic so looping works cleanly
	progress_ratio = loop_lerp(progress_ratio, target_progress, delta * travel_speed)
	
	# If close enough, snap to avoid jitter
	if abs(progress_ratio - target_progress) < 0.001:
		progress_ratio = target_progress

func _on_beat():
	# Move forward on each beat
	target_progress = wrapf(target_progress + speed_per_beat, 0.0, 1.0)

func loop_lerp(current: float, target: float, t: float) -> float:
	var diff = wrapf(target - current, -0.5, 0.5)
	return current+diff*t
