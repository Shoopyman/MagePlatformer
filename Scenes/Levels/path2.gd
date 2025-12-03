extends PathFollow2D

@export var pixels_per_step: float = 25.0     # how far to move each beat (in pixels)
@export var travel_speed: float = 6.0         # smooth lerp speed

# internal state
var target_progress := 0.0
var step_progress := 0.0
@export var active := true

@onready var curve: Curve2D = (get_parent() as Path2D).curve
@onready var curve_length: float = curve.get_baked_length()
var steps := 1



func _ready():
	# How many discrete steps fit along the path?
	# (rounding ensures perfect alignment and prevents accumulating error)
	steps = max(1, int(round(curve_length / pixels_per_step)))
	step_progress = 1.0 / steps

	BeatManager.beat.connect(_on_beat)


func _process(delta):
	# Smooth movement toward target
	progress_ratio = loop_lerp(progress_ratio, target_progress, delta * travel_speed)

	# Snap when close enough (removes tiny jitters)
	if abs(progress_ratio - target_progress) < 0.001:
		progress_ratio = target_progress

func 

func _on_beat():
	# Advance exactly one quantized step each beat
	if not active:
		return
	target_progress = wrapf(target_progress + step_progress, 0.0, 1.0)


func loop_lerp(current: float, target: float, t: float) -> float:
	# Handles wrapping around 0–1 cleanly
	var diff = wrapf(target - current, -0.5, 0.5)
	return current + diff * t
