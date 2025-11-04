extends Area2D

# Respawn Player when entering area 2D
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		CheckpointManager.respawn_player()
