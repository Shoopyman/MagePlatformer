extends Node

# Tuba settings
@export var upward_floor_velocity = 50
@export var falling_speed = 550
@export var slam_cooldown = 0.25 #for use on ground

var slam_available = true
var is_slaming = false
var cooldown_timer = 0.0

func on_unlock():
	#play SFX of unlocking
	pass

func update(player, delta):
	
	if cooldown_timer > 0.0:
		cooldown_timer -= delta	
		
	# Update movement when slamming
	if is_slaming:
		print("Tuba slam working")
		#override velocity
		player.velocity.y = falling_speed
		
		#reset timers
		if player.is_on_floor():
			is_slaming = false
			slam_available = true
			cooldown_timer = slam_cooldown
		return
	
	# Activate Slam  
	if Input.is_action_just_pressed("slam") and slam_available and cooldown_timer <= 0.0:
		print("Tuba slam pressed")
		slam_available = false
		is_slaming = true
		#play sound of slam
		
func isSlamming():
	return is_slaming
