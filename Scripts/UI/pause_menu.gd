extends Control

func _ready():
	hide()

func resume():
	hide()
	get_tree().paused = false
	
func pause():
	show()
	get_tree().paused = true
	
func testEsc():
	if Input.is_action_just_pressed("Pause"):
		if not get_tree().paused:
			pause()
		else:
			resume()
		
func _on_resume_pressed():
	resume()
	
func _on_restart_pressed():
	TheaterManager.phase = 0
	TheaterManager.platformEnabled = false
	CheckpointManager.reset_to_default()
	resume()
	get_tree().reload_current_scene()
	
func _on_main_menu_pressed() -> void:
	TheaterManager.phase = 0
	TheaterManager.platformEnabled = false
	resume()
	get_tree().change_scene_to_file("res://Scenes/Main Menu/main_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _process(_delta):
	testEsc()
