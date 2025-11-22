extends Node2D

func _ready() -> void:
	CheckpointManager.current_scene_progression = Vector2(0,0)
	CheckpointManager.current_checkpoint_position = Vector2(0,0)
	pass


func _on_demo_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/demo_stage.tscn")


func _on_tutorial_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/tutorial_level.tscn")


func _on_delete_later_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Level.tscn")


func _on_button_pressed() -> void:
	get_tree().quit()


func _on_level_1_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Junkyard.tscn")
	
