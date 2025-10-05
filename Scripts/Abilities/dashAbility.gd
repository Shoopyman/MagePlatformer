extends Node

# --- Dash Settings ---
@export var dash_speed = 500.0
@export var dash_duration = 0.2 #seconds
@export var dash_cooldown = 0.3 #for use on ground

var dash_available = true
var is_dashing = false
var dash_timer = 0.0
var dash_dir = 0


func update(player, delta):
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
	
	else:
		if player.is_on_floor():
			dash_available = true
	
	if Input.is_action_just_pressed("dash") and dash_available:
		dash_available = false
		is_dashing = true
		dash_timer = dash_duration
		var axis_of_input = sign(Input.get_axis("ui_left","ui_right"))
		dash_dir = axis_of_input if axis_of_input != 0 else player.facing_direction
		player.velocity = Vector2(dash_dir*dash_speed, 0)
	elif not is_dashing:
		return #go back to normal physics process
		
	player.move_and_slide() 
