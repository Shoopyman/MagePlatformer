extends Node

#Constants
@export var jump_velocity = -400
@export var max_extra_jumps = 1

#Setting up variables
var jumps_left = 0
var is_enabled = true

#Reset total double jump value when touching ground
func reset_jumps():
	if is_enabled:
		jumps_left = max_extra_jumps

#If power up is enabled and haven't double jumped yet, return 
#the jump velocity so player can jump again, otherwise return 0
func try_double_jump() -> float:
	if is_enabled && jumps_left > 0:
		jumps_left -= 1
		return jump_velocity 
	return 0.0
	
	
