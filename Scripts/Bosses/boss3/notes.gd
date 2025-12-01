extends Area2D

@export var noteSpeed = 0


func _on_body_entered(body: Node2D) -> void:
	print(body.is_in_group("noteDelete"))
	print("ENTERED:", body)
	print("Body groups:", body.get_groups())
	print("This node:", self)
	if(body.is_in_group("player")):
		CheckpointManager.load_saved_progression()
		return
	elif (body is TileMapLayer and TheaterManager.phase == 0):
		queue_free()
		return
	elif body.is_in_group("noteDelete"):
		print("why thids work now")
		return
		queue_free()
	elif get_parent().global_position.y > -2255:
		queue_free()
	else:
		print("note not deleteing")
		pass

func _physics_process(delta: float) -> void:
	global_position.y += noteSpeed*delta
	
