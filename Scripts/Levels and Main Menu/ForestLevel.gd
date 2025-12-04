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
	player.global_position.x = 8700
	player.global_position.y = 144
	camera.global_position.x = 8700
	camera.global_position.y = 144
	

func change_scene():
	MusicManager.stop_track()
	get_tree().change_scene_to_file("res://Scenes/Bosses/boss2/testScene.tscn")

func _on_boss_spawn_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		UI.speak([
			{
				"speaker": "Madam",
				"portrait": "forest_eyes_closed",
				"text": ""
			},
			{
				"speaker": "Madam",
				"portrait": "forest_eyes_closed",
				"text": "goo goo ga ga"
			},
		], change_scene)
