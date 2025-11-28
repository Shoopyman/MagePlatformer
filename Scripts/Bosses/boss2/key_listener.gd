extends Sprite2D

#Credit goes to https://www.youtube.com/watch?v=lhrqsUZ45j8&t=1302s

@onready var falling_key = preload("res://Scenes/Bosses/boss2/FallingKeys.tscn")
@export var key_name: String = ""
@onready var timer = $RandomSpawnTimer

var falling_key_queue = []

var failed_threshold: float = 65
var healthIncrease = 5
var healthDecrease = 10

func _ready() -> void:
	$GlowOverlay.frame = frame+4
	$AnimationPlayer.play("idle")
	Signals.CreateFallingKey.connect(CreateFallingKey)

func _process(_delta):
	
	if Input.is_action_just_pressed(key_name):
		Signals.KeyListenerPress.emit(key_name, frame)
	
	if falling_key_queue.size() > 0:
		if falling_key_queue.front().has_passed:
			falling_key_queue.pop_front()
			Signals.DecremetScore.emit(healthDecrease)
			
		if Input.is_action_just_pressed(key_name):
			
			var key_to_pop = falling_key_queue.pop_front()
			
			var distance_from_pass = abs(key_to_pop.pass_threshold - key_to_pop.global_position.y)
			
			$AnimationPlayer.stop()
			$AnimationPlayer.play("key_hit")
			
			if(distance_from_pass <= failed_threshold):
				Signals.IncremetScore.emit(healthIncrease)
			else:
				Signals.DecremetScore.emit(healthDecrease)
				
			key_to_pop.queue_free()

func CreateFallingKey(button_name: String):
	if button_name == key_name:	
		var fk_inst = falling_key.instantiate()
		get_tree().current_scene.call_deferred("add_child", fk_inst)
		fk_inst.Setup(position.x, frame + 4)
		falling_key_queue.push_back(fk_inst)

func _on_random_spawn_timer_timeout() -> void:
	#CreateFallingKey()
	timer.wait_time = randf_range(.4, 3)
	timer.start()
	
func _exit_tree():
	Signals.CreateFallingKey.disconnect(CreateFallingKey)
