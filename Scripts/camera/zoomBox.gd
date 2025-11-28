extends Area2D

@export var zoomFactor := Vector2(1.0, 1.0)

func _on_zoom_body_entered(body: Node2D) -> void:
	if not body. is_in_group("player"):
		return
	var cam := get_tree().current_scene.get_node("Camera2D")
	cam.set_zoom_smooth(zoomFactor, 0.5)


func _on_zoom_body_exited(body: Node2D) -> void:
	if not body. is_in_group("player"):
		return
	var cam := get_tree().current_scene.get_node("Camera2D")
	cam.set_zoom_smooth(Vector2(1.0, 1.0), 0.5)
