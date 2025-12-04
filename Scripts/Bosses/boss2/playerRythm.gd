extends AnimatedSprite2D

@onready var health_bar = $Boss2Ui/HealthBarPlayer
@export var timeout: float = 0.4
var hp = 100
var inactivity_timer: Timer

func _ready():
	health_bar.value = hp
	Signals.IncremetScore.connect(IncremetScore)
	Signals.DecremetScore.connect(DecremetScore)
	stop()
	inactivity_timer = Timer.new()
	inactivity_timer.one_shot = true
	inactivity_timer.wait_time = timeout
	add_child(inactivity_timer)
	inactivity_timer.connect("timeout", _on_inactive)
	
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

# total frames in your animation
@export var frame_count: int = 4

func _input(event):
	if event.is_action_pressed("left"):
		frame = 2 

	if event.is_action_pressed("right"):
		frame = 3  

	if event.is_action_pressed("down"):
		frame = 1    
		
		

	inactivity_timer.start()

func _on_inactive():
	frame = 0

func DecremetScore (incr: int):
	hp -= incr
