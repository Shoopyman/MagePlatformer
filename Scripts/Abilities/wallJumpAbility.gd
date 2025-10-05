extends Node

@export var wall_jump_hori = 550
@export var wall_jump_verti = -400

func update(player, _delta):
	var touching_left = player.is_on_wall() and player.get_wall_normal().x >0
	var touching_right = player.is_on_wall() and player.get_wall_normal().x <0
	
	if Input.is_action_just_pressed("jump"):
		if touching_left:
			player.velocity.x = wall_jump_hori
			player.velocity.y = wall_jump_verti
		elif touching_right:
			player.velocity.x = -wall_jump_hori
			player.velocity.y = wall_jump_verti
			
