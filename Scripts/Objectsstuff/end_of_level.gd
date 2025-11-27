extends Area2D



func _change_to_main_menu()-> void:
	get_tree().change_scene_to_file("res://Scenes/Main Menu/main_menu.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		call_deferred("_change_to_main_menu")
		
	TheaterManager.phase = 0
	TheaterManager.platformEnabled = false
