extends AnimatedSprite2D

@onready var health_bar = $Boss2Ui/HealthBarPlayer

var hp = 100

func _ready():
	health_bar.value = hp
	Signals.IncremetScore.connect(IncremetScore)
	Signals.DecremetScore.connect(DecremetScore)
	
func _process(_delta):
	health_bar.value = hp

func IncremetScore (incr: int):
	if(hp<100 && hp+5 < 100):
		hp += incr
	elif(hp<100 && hp+5>= 100):
		hp=100
	#boss_bar.value -= 10
	#if(boss_bar.value < 0):
		#boss_bar.value = 1

func DecremetScore (incr: int):
	hp -= incr
