extends Area2D

var player_inside: Node2D = null

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = body
		_check_break() # immediate check in case already slamming

func _on_body_exited(body: Node2D) -> void:
	if body == player_inside:
		player_inside = null

func _physics_process(_delta: float) -> void:
	_check_break()

func _check_break() -> void:
	if player_inside and (player_inside.is_dashing() or player_inside.is_slamming()):
		_break_box()

func _break_box():
	var parent = get_parent()
	var static_body := parent.get_node("StaticBody2D")

	# Disable collisions immediately
	if static_body:
		for shape in static_body.get_children():
			if shape is CollisionShape2D:
				shape.call_deferred("set_disabled", true)
		static_body.collision_layer = 0
		static_body.collision_mask = 0

	# Optional: hide instantly
	parent.visible = false

	# Delay one frame before freeing to avoid physics artifacts
	await get_tree().process_frame
	parent.queue_free()
