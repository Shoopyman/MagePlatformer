extends Node

@export var wall_jump_hori = 550
@export var wall_jump_verti = -400
@export var wall_slide_gravity = 150      # lower gravity while sliding
@export var wall_slide_max_speed = 120    # downward cap while sliding
@export var enable_wall_slide = true

func update(player, delta):

	# ---- WALL SLIDE ----
	var sliding = false

	if enable_wall_slide \
	and player.is_on_wall() \
	and not player.is_on_floor() \
	and player.velocity.y > 0:    # only slide when falling

		sliding = true

		# apply reduced gravity
		player.velocity.y += wall_slide_gravity * delta
		
		# cap slide speed
		if player.velocity.y > wall_slide_max_speed:
			player.velocity.y = wall_slide_max_speed

	# ---- WALL JUMP ----
	if Input.is_action_just_pressed("jump") \
	and player.is_on_wall() \
	and not player.is_on_floor():

		var normal = player.get_wall_normal()

		if normal.x > 0:
			player.velocity.x = wall_jump_hori
			player.velocity.y = wall_jump_verti
		elif normal.x < 0:
			player.velocity.x = -wall_jump_hori
			player.velocity.y = wall_jump_verti

		# reset buffer timers
		if "coyote_timer" in player:
			player.coyote_timer = 0
		if "jump_buffer_timer" in player:
			player.jump_buffer_timer = 0
		
		var cymbalsAnim = preload("res://Scenes/Particles/wall_jump_cymbals.tscn").instantiate()
		cymbalsAnim.global_position = player.global_position + Vector2(0, 10)
		get_tree().current_scene.add_child(cymbalsAnim)
		get_parent().play_sfx("wall_jump")
