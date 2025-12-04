extends Control

@onready var body: Label = $VBoxContainer/dialogueBox/DialogueText
@onready var speaker: Label = $VBoxContainer/dialogueBox/NameText
@onready var portrait: AnimatedSprite2D = $VBoxContainer/dialogueBox/ColorRect/Portrait

const TEXT_RATE = 1 #number of frames between updates
const SHORT_PAUSE = 6 #number of frames to wait on a comma, dash, etc.
const FULL_PAUSE = 10 #number of frames to wait on periods, marks, etc.

var short_pauses = [",", "-"]
var full_pauses = [".", "!", "?", "_"]

var dialogue := []
var index := 0
var timer := -1.0

var sub_text := ""
var pause := 0
var cur := 0
var length := 0

var on_dialogue_end: Callable

func start_dialogue(entries: Array, callback: Callable):
	dialogue = entries
	on_dialogue_end = callback
	index = 0
	Global.input_locked = true
	show()
	draw_dialogue()

func draw_dialogue():
	if index >= dialogue.size():
		Global.input_locked = false
		if not on_dialogue_end == null:
			on_dialogue_end.call()
		hide()
		return
	
	var entry = dialogue[index]
	speaker.text = entry.get("speaker", "")
	portrait.play(entry.get("portrait", ""))
	sub_text = entry.get("text", "")
	timer = entry.get("time", -1.0)
	
	length = sub_text.length()
	cur = 0
	pause = 0

func _unhandled_input(event):
	if visible and event.is_action_pressed("Interact") and timer <= 0:
		index += 1
		draw_dialogue()

func _ready():
	hide()

func _process(delta):
	if cur < length:
		if pause == 0:
			body.text = sub_text.substr(0, cur+1)
			if sub_text[cur] in short_pauses:
				pause = SHORT_PAUSE
			elif sub_text[cur] in full_pauses:
				pause = FULL_PAUSE
			else:
				pause = TEXT_RATE
			cur += 1
		else:
			pause -= 1
	else:
		timer -= delta
		if timer < 0 and timer > -1:
			index += 1
			draw_dialogue()
