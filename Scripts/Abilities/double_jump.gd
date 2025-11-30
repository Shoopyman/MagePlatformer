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
		var bongoAnim = preload("res://Scenes/Particles/double_jump_bongo.tscn").instantiate()
		bongoAnim.global_position = player.global_position + Vector2(0, 10)
		get_tree().current_scene.add_child(bongoAnim)
		
		get_parent().play_sfx("double_jump")
	
func on_equipped(player):
	jumps_left = max_extra_jumps
