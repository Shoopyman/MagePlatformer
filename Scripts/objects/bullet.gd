extends Area2D

var direction: Vector2 = Vector2.ZERO
var speed := 400.0

func _physics_process(delta):
	global_position += direction * speed * delta



func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("player")):
		pass
		CheckpointManager.load_saved_progression()
	else:
		queue_free()
