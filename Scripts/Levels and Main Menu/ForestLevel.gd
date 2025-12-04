extends Node2D

@onready var UI = $UILayer/game_ui
@onready var player = $Player

@export var bpm: float = 76.0
@onready var camera = $Camera2D

func _ready():
	CheckpointManager.respawn_player()
	camera.matchPositionToPlayer()
	MusicManager.play_track("res://Sound/Music/ForestMusic.mp3")
	BeatManager.set_bpm(bpm)
	

func change_scene():
	MusicManager.stop_track()
	get_tree().change_scene_to_file("res://Scenes/Bosses/boss2/testScene.tscn")

func _on_boss_spawn_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		UI.speak([
			{
				"speaker": "Lucia",
				"portrait": "forest_surprised",
				"text": "Wow, you really made it here quick. "
			},
			{
				"speaker": "Lucia",
				"portrait": "forest_talking",
				"text": "I saw you come into the forest, and you've really outdone yourself on the music!"
			},
			{
				"speaker": "Lucia",
				"portrait": "forest_neutral",
				"text": "you know...    I'm somewhat of a composer myself, *#"
			},
			{
				"speaker": "Lucia",
				"portrait": "forest_smile",
				"text": "Would you try to do some dance moves to a little song I wrote? &&"
			},
			{
				"speaker": "Lucia",
				"portrait": "forest_eyes_closed",
				"text": "I would be so sad if it was impossible I might kill somebody. &*@"
			},
			{
				"speaker": "Lucia",
				"portrait": "forest_talking",
				"text": "I can tell by your face you're ready so lets go RIGHT NOW"
			},
		], change_scene)
