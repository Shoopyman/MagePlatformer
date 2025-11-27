extends Node

@onready var player := AudioStreamPlayer.new()

var current_track_path = ""

func _ready():
	add_child(player)

func play_track(path: String):
	# Don't restart if the same song is already playing
	if path == current_track_path and player.playing:
		return

	current_track_path = path
	player.stream = load(path)
	player.play()
