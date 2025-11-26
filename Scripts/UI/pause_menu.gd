extends Control


func _on_resume_pressed():
	print("Resume")
	
func _on_restart_pressed():
	print("Restart")
	CheckpointManager.reset_to_default()
	get_tree().reload_current_scene()
	
func _on_main_menu_pressed() -> void:
	print("Main Menu")
	get_tree().change_scene_to_file("res://Scenes/Main Menu/main_menu.tscn")

func _on_quit_pressed() -> void:
	print("quit")
	get_tree().quit()
