extends Node

#Constants
@export var jump_velocity = -370
@export var max_extra_jumps = 1

#Setting up variables
var jumps_left = 0
var is_enabled = true

func update(player, delta):
	if player.is_on_floor():
		jumps_left = max_extra_jumps
	
	if Input.is_action_just_pressed("jump") and not player.is_on_floor() and not player.is_on_wall() and jumps_left > 0:
		jumps_left -= 1
		player.velocity.y = jump_velocity
		#player.oneOff = true
	
func on_equipped(player):
	jumps_left = max_extra_jumps
