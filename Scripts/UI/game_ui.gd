extends Control

@onready var dialogueBox = $screen/bottomDialogue

func speak(entries: Array, callback: Callable):
	if not Global.input_locked:
		dialogueBox.start_dialogue(entries, callback);
