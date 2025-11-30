extends Node

# Tuba settings
@export var upward_floor_velocity = 50
@export var falling_speed = 550
@export var slam_cooldown = 0.50 #for use on ground
@export var ricochet_height = 150 #ask me what these do cus honestly explaining it is hard
@export var rebound_height = 300 #ask me what these do cus honestly explaining it is hard

var slam_available = true
var is_slaming = false
var cooldown_timer = 0.0
var ricochet_timer = -10.0

var rebound_timer = 0.0
signal ability_used(ability_name)


func on_unlock():
	#play SFX of unlocking
	pass

func update(player, delta):
	# Update movement when slamming
	if is_slaming:
		#override velocity
		player.velocity.y = falling_speed
		player.oneOff = true
		player.sprite.frame = 0
		player.sprite.play("slam")
		
		rebound_timer += delta
		
		#reset timers
		if player.is_on_floor():
			is_slaming = false
			slam_available = true
			cooldown_timer = slam_cooldown
			ricochet_timer = 0.01
		return
	
	# Activate Slam  
	if Input.is_action_just_pressed("dash") and slam_available and cooldown_timer <= 0.0:
		print("Tuba slam pressed")
		slam_available = false
		is_slaming = true
		#play sound of slam
		get_parent().play_sfx("slam")
	
	if cooldown_timer > 0.0:
		cooldown_timer -= delta
	
	# messiest code of history
	if ricochet_timer > 0.0:
		if not player.is_on_floor():
			ricochet_timer = -10.0
			is_slaming = true
		ricochet_timer -= delta
	elif ricochet_timer > -10.0:
		var dustAnim = preload("res://Scenes/Particles/dust.tscn").instantiate()
		dustAnim.global_position = player.global_position + Vector2(0, 5)
		get_tree().current_scene.add_child(dustAnim)
		
		if rebound_timer < 0.02:
			player.bounce(rebound_height)
		else:
			player.bounce(ricochet_height)
		
		ricochet_timer = -10.0
		rebound_timer = 0.0
	elif player.velocity.x != 0 and player.is_on_floor():
			player.oneOff = false

func isSlamming():
	return is_slaming
