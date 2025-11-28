extends Node2D

var timer = 0



func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		CheckpointManager.load_saved_progression() # Replace with function body.
