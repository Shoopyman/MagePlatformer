extends Control

func _ready():
	hide()
	$AnimationPlayer.play("RESET")

func resume():
	hide()
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	show()
	get_tree().paused = true
	$AnimationPlayer.play("blur")
func testEsc():
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
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
