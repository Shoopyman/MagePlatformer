extends Node2D

@onready var animations = $AnimationPlayer
@onready var boss = $"Boss Room/Engineer"
@onready var spikeWall =$SpikeWall/CharacterBody2D

@export var bpm: float = 126.0

@onready var testDialogue = $Camera2D/dialogue1
@onready var camera = $Camera2D

func _ready()->void:
	CheckpointManager.respawn_player()
	camera.matchPositionToPlayer()
	boss.process_mode = Node.PROCESS_MODE_DISABLED
	boss.set_physics_process(false)
	boss.set_process(false)
	boss.connect("boss_defeated", Callable(self, "_on_boss_defeated"))
	spikeWall.hide()
	animations.play('crane-swing')
	MusicManager.play_track("res://Sound/Music/metForGame25.wav")
	BeatManager.set_bpm(bpm)
	var spb = 60.0 / bpm
	var t = MusicManager.player.get_playback_position()
	BeatManager.beat_offset = ceil(t / spb) - (t / spb)
#Add Area 2d for when spike wall to descend
#Add area 2d to begin cutscene of boss intro


func _on_boss_spawn_cutscene_body_entered(body: Node2D) -> void:
	if(body.is_in_group('player')):
		#animations.play('bossSpawn')
		boss.process_mode = Node.PROCESS_MODE_INHERIT
		boss.set_physics_process(true)
		boss.set_process(true)
	
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
		


func _on_test_sign_body_entered(body: Node2D) -> void:
	if testDialogue.visible == false:
		testDialogue.start_dialogue([
			{
				"speaker": "Man",
				"portrait": "junkyard_smug",
				"text": "This is the first message. Make sure that the text wraps properly. Press E to go next."
			},
			{
				"speaker": "Man",
				"portrait": "junkyard_sad",
				"text": "This is the second message. Periods and exclamation marks have a slight delay. 67! 67! 67!"
			},
			{
				"speaker": "Man",
				"portrait": "junkyard_laugh",
				"text": "This is the last message. If the dialogue box closes without breaking everything, success!"
			},
		]) # Replace with function body.
