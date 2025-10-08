extends Node

# --- Dash Settings ---
@export var dash_speed = 700.0
@export var dash_duration = 0.15 #seconds
@export var dash_cooldown = 0.25 #for use on ground

var dash_available = true
var is_dashing = false
var dash_timer = 0.0
var dash_dir = 0
var cooldown_timer = 0.0

func on_unlock():
	# play unlock vfx Trombone solo
	pass

func update(player, delta):
	
	if cooldown_timer > 0.0:
		cooldown_timer -= delta
	
	if is_dashing:
		dash_timer -= delta
		#override velocity
		player.velocity.x = dash_dir*dash_speed
		player.velocity.y = 0
		if dash_timer <= 0.0:
			is_dashing = false
			cooldown_timer = dash_cooldown
		return
	
	if player.is_on_floor():
		dash_available = true
	
	# activate dash
	if Input.is_action_just_pressed("dash") and dash_available and cooldown_timer <= 0.0:
		dash_available = false
		is_dashing = true
		dash_timer = dash_duration
		var axis = int(sign(Input.get_axis("ui_left","ui_right")))
		dash_dir = axis if axis != 0 else player.facing_direction
		player.velocity.y = 0
		# PLAY SOUND OF DASH
