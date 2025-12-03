extends Area2D

@export var noteSpeed = 0


func _on_body_entered(body: Node2D) -> void:
	
	if(body.is_in_group("player")):
		CheckpointManager.load_saved_progression()
		return
	elif (body is TileMapLayer):
		#get_parent().explodeNote()
		queue_free()
		return
	

func _physics_process(delta: float) -> void:
	global_position.y += noteSpeed*delta
	
