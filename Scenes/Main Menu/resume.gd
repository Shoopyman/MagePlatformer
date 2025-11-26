extends TextureButton


func _on_button_down() -> void:
	$resumeText.position.y = 0


func _on_button_up() -> void:
	$resumeText.position.y = -2
