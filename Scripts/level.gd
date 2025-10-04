extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	call_deferred("_change_to_main_menu")

func _change_to_main_menu()-> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
