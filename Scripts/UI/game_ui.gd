extends Control

@onready var dialogueBox = $screen/bottomDialogue

func speak(entries: Array):
	if not Global.input_locked:
		dialogueBox.start_dialogue(entries);

#func _ready():
#	speak([{"speaker": "Lady", "text": "Gyatt~!", "portrait": "forest_surprised"}])
