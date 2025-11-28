extends Sprite2D

#Credit goes to https://www.youtube.com/watch?v=lhrqsUZ45j8&t=1302s

@export var fall_speed: float = 5.5

var elapsed = 0
var inital_y_pos = -330
var has_passed = false
var pass_threshold = 330

func _init() -> void:
	set_process(false)

func _physics_process(delta: float) -> void:
	global_position += Vector2(0, fall_speed)
	
	if not $Timer.is_stopped():
		elapsed += delta
	
	if global_position.y > pass_threshold and not $Timer.is_stopped():
		#print("Timer wait time:", $Timer.wait_time-elapsed)
		$Timer.stop()
		has_passed = true
		return
		
func Setup(target_x: float, target_frame : int):
	global_position = Vector2(target_x, inital_y_pos)
	frame = target_frame
	set_process(true)

func _on_destroy_timer_timeout() -> void:
	queue_free()
