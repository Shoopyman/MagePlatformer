extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play("closed")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AnimatedSprite2D.play("activate")
		CheckpointManager.set_checkpoint(global_position)
