extends Area2D

@export var speed_threshold = 550

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.velocity.length() >= speed_threshold:
			queue_free()
			
