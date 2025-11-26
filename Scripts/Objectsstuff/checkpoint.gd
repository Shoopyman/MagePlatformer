extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("body signal")
	if body.is_in_group("player"):
		print("Player entered checkpoint")
		CheckpointManager.set_checkpoint(global_position)
