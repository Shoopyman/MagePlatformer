extends Area2D

@export_enum("FULL_FOLLOW", "LOCKED", "VERTICAL_ONLY", "HORIZONTAL_ONLY") var camera_mode := "" #dropdown in inspector
@export var move_to_center := true
@export_enum("FULL_FOLLOW", "LOCKED", "VERTICAL_ONLY", "HORIZONTAL_ONLY") var camera_restore := "FULL_FOLLOW"
func _on_body_entered(body):
	print("body entered")
	var cam := get_tree().current_scene.get_node("Camera2D")
	cam.follow_mode = camera_mode
	
	if move_to_center and camera_mode == "LOCKED":
		cam.locked_position = global_position
	elif move_to_center and camera_mode == "HORIZONTAL_ONLY":
		cam.locked_position.y = global_position.y
	elif move_to_center and camera_mode == "VERTICAL_ONLY":
		cam.locked_position.x = global_position.x

func _on_body_exited(body):
	var cam := get_tree().current_scene.get_node("Camera2D")
	cam.follow_mode = camera_restore
