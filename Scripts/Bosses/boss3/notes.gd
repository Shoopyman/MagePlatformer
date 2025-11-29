extends Area2D

@export var noteSpeed = 0


func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		CheckpointManager.load_saved_progression()
	elif body is TileMapLayer:
		queue_free()
	else:
		pass

func _physics_process(delta: float) -> void:
	global_position.y += noteSpeed*delta
	
