extends Node2D

@onready var label = $Label
@onready var hover = $hover
@export var text = ""

func _ready() -> void:
	label.text = text
	label.hide()
	hover.hide()

func _physics_process(delta: float) -> void:
	if hover.visible:
		if (Input.is_action_just_pressed('Interact')) && !label.visible:
			label.show()
		elif (Input.is_action_just_pressed('Interact')) && label.visible:
			label.hide()
			
func _on_area_2d_body_entered(body: Node2D) -> void:
	hover.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	hover.hide()
