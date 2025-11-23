extends Node2D

@onready var label =$Label
var inArea: bool = false
var textShowing: bool = false

func _ready() -> void:
	label.hide()

func _physics_process(delta: float) -> void:
	if(inArea):
		if (Input.is_action_just_pressed('Interact')) && textShowing == false:
			label.show()
			textShowing = true
		elif (Input.is_action_just_pressed('Interact')) && textShowing == true:
			print("Bye Label")
			label.hide()
			textShowing = false
			
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group('player')):
		inArea = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	inArea = false
