extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		CheckpointManager.set_checkpoint(global_position)
		body.ability_manager.current_ability = null
