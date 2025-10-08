extends Node

@export var wall_jump_hori = 550
@export var wall_jump_verti = -400

func on_unlock():
	#play SFX of unlcoking
	pass

func update(player, delta):
	
	if Input.is_action_just_pressed("jump") and player.is_on_wall() and not player.is_on_floor():
		var normal = player.get_wall_normal()
		
		if normal.x > 0:
			player.velocity.x = wall_jump_hori
			player.velocity.y = wall_jump_verti
		elif normal.x < 0:
			player.velocity.x = -wall_jump_hori
			player.velocity.y = wall_jump_verti

		# reset coyote/jump buffer
		if "coyote_timer" in player:
			player.coyote_timer = 0
		if "jump_buffer_timer" in player:
			player.jump_buffer_timer = 0

# no coyote time for the walljumps,
# but they should be more precise and less forgiving
