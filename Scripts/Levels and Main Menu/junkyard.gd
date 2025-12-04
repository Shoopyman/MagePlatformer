extends Node2D

@onready var animations = $AnimationPlayer
@onready var boss = $"Boss Room/Engineer"
@onready var spikeWall =$SpikeWall/CharacterBody2D

@export var bpm: float = 110.0

@onready var UI = $UILayer/game_ui
@onready var camera = $Camera2D

@onready var player = $Player

signal boss_spawn()

func _ready()->void:
	CheckpointManager.respawn_player()
	camera.matchPositionToPlayer()
	boss.process_mode = Node.PROCESS_MODE_DISABLED
	boss.set_physics_process(false)
	boss.set_process(false)
	boss.connect("boss_defeated", Callable(self, "_on_boss_defeated"))
	spikeWall.hide()
	animations.play('crane-swing')
	MusicManager.play_track("res://Sound/Music/JunkyardFRFR.mp3")
	BeatManager.set_bpm(bpm)
	var spb = 60.0 / bpm
	var t = MusicManager.player.get_playback_position()
	BeatManager.beat_offset = ceil(t / spb) - (t / spb)
	camera.follow_mode = "FULL_FOLLOW"
	CheckpointManager.respawn_player()
#Add Area 2d for when spike wall to descend
#Add area 2d to begin cutscene of boss intro


func _on_boss_spawn_cutscene_body_entered(body: Node2D) -> void:
	if(body.is_in_group('player')):
		if not Global.didBoss1Dialogue:
			MusicManager.stop_track()
			UI.speak([
				{
					"speaker": "Junkyard Boss",
					"portrait": "junkyard_smug",
					"text": "Well well well."
				},
			], _on_boss_spawn)
			Global.didBoss1Dialogue = true
		else:
			emit_signal("boss_spawn")
		#animations.play('bossSpawn')
	
func _on_boss_defeated():
	#Disbale Boss node
	boss.process_mode = Node.PROCESS_MODE_DISABLED
	boss.set_physics_process(false)
	boss.set_process(false)
	boss.hide()


func _on_spike_wall_flag_body_entered(body: Node2D) -> void:
	if(body.is_in_group('player')):
		#animations.play('spikeWallDescends')
		spikeWall.show()
		spikeWall.active = true
		
		

func _on_bug_test_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player.global_position.x = 11962
		player.global_position.y = -607
		camera.global_position.x = 11962
		camera.global_position.y = -607


func _on_boss_spawn() -> void:
	MusicManager.stop_track()
	MusicManager.play_track("res://Sound/Music/JunkyardFRFR.mp3")
	boss.process_mode = Node.PROCESS_MODE_INHERIT
	boss.set_physics_process(true)
	boss.set_process(true)
