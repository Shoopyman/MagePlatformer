extends Control

@onready var button: TextureButton = $TextureButton
@onready var label: Label = $TextureButton/Label
@export var text: String = ""

signal pressed()

func _ready():
	# connect button signals
	label.offset_top = -1
	label.offset_bottom = -1
	label.text = text

func _on_texture_button_button_down() -> void:
	label.offset_top = 1
	label.offset_bottom = 1


func _on_texture_button_button_up() -> void:
	label.offset_top = -1
	label.offset_bottom = -1


func _on_texture_button_pressed() -> void:
	emit_signal("pressed")


func _on_texture_button_mouse_exited() -> void:
	label.offset_top = -1
	label.offset_bottom = -1
