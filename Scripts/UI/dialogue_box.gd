extends Control

@onready var body: Label = $DialogueText
@onready var speaker: Label = $NameText
@onready var portrait: AnimatedSprite2D = $Portrait

const TEXT_RATE = 1 #number of frames between updates
const SHORT_PAUSE = 6 #number of frames to wait on a comma, dash, etc.
const FULL_PAUSE = 10 #number of frames to wait on periods, marks, etc.

var short_pauses = [",", "-"]
var full_pauses = [".", "!", "?", "_"]

var dialogue := []
var index := 0

var sub_text := ""
var pause := 0
var cur := 0
var length := 0

func start_dialogue(entries: Array):
	dialogue = entries
	index = 0
	show()
	draw_dialogue()

func draw_dialogue():
	if index >= dialogue.size():
		hide()
		return
	
	var entry = dialogue[index]
	speaker.text = entry.get("speaker", "")
	portrait.play(entry.get("portrait", ""))
	
	sub_text = entry.get("text", "")
	length = sub_text.length()
	cur = 0
	pause = 0

func _unhandled_input(event):
	if visible and event.is_action_pressed("ui_next"):
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
