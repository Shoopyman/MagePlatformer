extends Node2D

var direction = 1 #Direction of spike wall movinf
var speed = 100 #How fast spike wall moves


func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	if()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group('player')):
		CheckpointManager.load_saved_progression()
	elif(body.is_in_group('destructible')):
		body.queue_free()
