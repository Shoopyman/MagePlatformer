extends Area2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("_on_body_entered")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		CheckpointManager.respawn_player()
