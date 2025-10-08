extends Node2D


func _on_demo_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/demo_stage.tscn")


func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/tutorial.tscn")


func _on_delete_later_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Level.tscn")
