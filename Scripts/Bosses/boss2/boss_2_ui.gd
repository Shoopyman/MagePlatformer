extends Control

var healthChange = 0

func _ready():
	Signals.IncremetScore.connect(IncremetScore)
	Signals.DecremetScore.connect(DecremetScore)
	
func IncremetScore (incr: int):
	healthChange += incr
	$HealthBarPlayer.value += healthChange

func DecremetScore (incr: int):
	healthChange -= incr
	$HealthBarPlayer.value -= healthChange
