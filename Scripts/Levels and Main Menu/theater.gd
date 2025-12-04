extends Node2D

@export var bpm: float = 108.0

@onready var player = $Player
@onready var camera = $Camera2D
@onready var timer = $Timer
@onready var test = $TestTimer
@onready var warp2 = $Warps/Warp2/CollisionShape2D
@onready var cam = $Camera2D
@onready var noteBoss = $NoteRoom/Boss_Summon_Notes
@onready var notes = $NoteRoom/RandomNoteSpawn
@onready var bossChase1 = $BossChase/BossChase1
@onready var bossChase2 = $BossChase/BossChase2
@onready var bossChase3 = $BossChase/BossChase3
@onready var animationPlayer1 = $AnimationPlayer
@onready var fallingPiano = $FallingPiano
@onready var bossSpriteIntro = $AnimatedSprite2D
@onready var UI = $UILayer/game_ui

var timeLeft = 30
var inBox = false

func _ready() -> void:
	#SETUP AND HIDE NODES IN BACKGROUND
	CheckpointManager.respawn_player()
	MusicManager.play_track("res://Sound/Music/theaterBoss.mp3")
	BeatManager.set_bpm(bpm)
	camera.matchPositionToPlayer()
	notes.process_mode = Node.PROCESS_MODE_DISABLED
	notes.set_physics_process(false)
	notes.set_process(false)
	noteBoss.process_mode = Node.PROCESS_MODE_DISABLED
	noteBoss.set_physics_process(false)
	noteBoss.set_process(false)
	noteBoss.hide()
	timer.wait_time = 2
	timer.one_shot = true
	bossChase1.hide()
	bossChase1.process_mode = Node.PROCESS_MODE_DISABLED
	bossChase1.set_physics_process(false)
	bossChase1.set_process(false)
	bossChase1.horiztonal = true
	bossChase2.hide()
	bossChase2.process_mode = Node.PROCESS_MODE_DISABLED
	bossChase2.set_physics_process(false)
	bossChase2.set_process(false)
	bossChase2.horiztonal = true
	bossChase3.hide()
	bossChase3.process_mode = Node.PROCESS_MODE_DISABLED
	bossChase3.set_physics_process(false)
	bossChase3.set_process(false)
	if(TheaterManager.warp2Enabled == false):
		warp2.set_deferred("disabled", true)
	randomize()
	bossSpriteIntro.play("Idle")
	$AnimatedSprite2D/AnimatedSprite2D.play("Idle")
	
	
	
	
func _physics_process(delta: float) -> void:
	#SET TIMER CAN DELETE THE FIRST IF STATEMENT LATER
	if(inBox):
		test.text = "Time Left: %.0f" % timeLeft
		timeLeft -= delta
	#Makes sure platfoprm runs if player dies during that sequeunce

func _on_warp_1_body_entered(body: Node2D) -> void:
	#Teleports player/Camera to note room
	if(body.is_in_group("player")):
		UI.speak([
				{
					"speaker": "Dux of Sound",
					"portrait": "theater_talking",
					"text": "Welcome one and all to a grand performace."
				},
				{
					"speaker": "Dux of Sound",
					"portrait": "theater_smirk",
					"text": "Here you will be witnessing the show of a lifetime."
				},
				{
					"speaker": "Dux of Sound",
					"portrait": "theater_smirk",
					"text": "Your lead performer, the star of the theater, the greatest actor of all time"
				},
				{
					"speaker": "Dux of Sound",
					"portrait": "theater_nervous",
					"text": "Will be performing with a plebeian."
				},
				{
					"speaker": "Dux of Sound",
					"portrait": "theater_angry",
					"text": "Honestly, it annoys me that anyone think they can just walk in and perform with a star actor"
				},
				{
					"speaker": "Dux of Sound",
					"portrait": "theater_smirk",
					"text": "Oh well, let the show begin."
				},
			],hi)
		
			
func hi():
	player.global_position.x = 1259 
	player.global_position.y = -2266
	cam.global_position.x = 1259
	cam.global_position.y = -2266
	
		


func _on_timer_timeout() -> void:
	#Teleports player to first half of chase
	if TheaterManager.phase == 0:
		player.global_position.x = 3766
		player.global_position.y = -36
		player.ability_manager.current_ability = null
		timer.wait_time = 2
		timer.one_shot = true
		cam.global_position.x = 3766
		cam.global_position.y = -36
	#Teleorts player to second half of chase with floating platform
	elif TheaterManager.phase == 1:
		player.global_position.x = 5834
		player.global_position.y = 77
		cam.global_position.x = 5834
		cam.global_position.y = 77
		TheaterManager.platformEnabled = true
		player.ability_manager.current_ability = null
	TheaterManager.phase += 1
	#DISBALES MUSICN NOTE BOSS SCRIPT
	notes.process_mode = Node.PROCESS_MODE_DISABLED
	notes.set_physics_process(false)
	notes.set_process(false)
	notes.phase += 1
	noteBoss.process_mode = Node.PROCESS_MODE_DISABLED
	noteBoss.set_physics_process(false)
	noteBoss.set_process(false)
	noteBoss.hide()
	$Abilties/SpeicalAbility/CollisionShape2D.set_deferred("disabled", false)
	for child in notes.get_children():
		if child != notes.get_node("Area2D"):  # Keep the Area2D if needed
			child.queue_free()

#DELETE LATER WHEN FINISHED
func _on_bug_test_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player.global_position.x = 580
		player.global_position.y = 1746
		cam.global_position.x = 580
		cam.global_position.y = 1746
		TheaterManager.platformEnabled = true


#Teleports back to Note room
func _on_warp_2_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player.global_position.x = 1259 
		player.global_position.y = -2266
		cam.global_position.x = 1259
		cam.global_position.y = -2266
		$Abilties/SpeicalAbility/CollisionShape2D.disabled = false
		$Abilties/SpeicalAbility/Sprite2D.show()
		body.ability_manager.current_ability = null
		TheaterManager.warp2Enabled = false
		bossChase1.hide()
		bossChase1.process_mode = Node.PROCESS_MODE_DISABLED
		bossChase1.set_physics_process(false)
		bossChase1.set_process(false)
		bossChase1.horiztonal = true
		

#Teleport to mushroom bounce and despawns third chase boss
func _on_warp_3_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player.global_position.x = 3723
		player.global_position.y = 1489
		cam.global_position.x = 3723
		cam.global_position.y = 1469
		body.ability_manager.current_ability = null
		bossChase3.hide()
		bossChase3.process_mode = Node.PROCESS_MODE_DISABLED
		bossChase3.set_physics_process(false)
		bossChase3.set_process(false)

#Teleports to final room
func _on_warp_4_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player.global_position.x = 580
		player.global_position.y = 1746
		cam.global_position.x = 580
		cam.global_position.y = 1746
		body.ability_manager.current_ability = null
		

#SCRIPT FOR SPECIAL INSTRUMENT TO SPAWN BOSS IN MUSIC ROOM
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		timer.start()
		inBox = true
		var am = body.get_node("AbilityManager") if body.has_node("AbilityManager") else null
		if am:
			print("Unlocking Ability:", "trombone")
			am.unlock("trombone", body)
		else:
			print("ERROR: Player missing AbilityManager")
		$Abilties/SpeicalAbility/Sprite2D.hide()
		$Abilties/SpeicalAbility/CollisionShape2D.set_deferred("disabled", true)
		notes.process_mode = Node.PROCESS_MODE_INHERIT
		notes.set_physics_process(true)
		notes.set_process(true)
		noteBoss.process_mode = Node.PROCESS_MODE_INHERIT
		noteBoss.set_physics_process(true)
		noteBoss.set_process(true)
		noteBoss.show()


#CHECKPOINT THAT SPAWNS FIRST CHASE BOSS
func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		bossChase1.show()
		bossChase1.process_mode = Node.PROCESS_MODE_INHERIT
		bossChase1.set_physics_process(true)
		bossChase1.set_process(true)
		bossChase1.horiztonal = true

#CHECKPOINT THAT SPAWNS SECOND CHASE BOSS
func _on_invisible_checkpoint_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		bossChase2.show()
		bossChase2.process_mode = Node.PROCESS_MODE_INHERIT
		bossChase2.set_physics_process(true)
		bossChase2.set_process(true)
		bossChase2.horiztonal = true
		warp2.set_deferred("disabled", true)

#AREA2D that spawns 3rd boss going vertical and despawns second chase boss
func _on_boss_chase_3_spawn_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		bossChase2.hide()
		bossChase2.process_mode = Node.PROCESS_MODE_DISABLED
		bossChase2.set_physics_process(false)
		bossChase2.set_process(false)
		bossChase2.horiztonal = true
		bossChase3.show()
		bossChase3.process_mode = Node.PROCESS_MODE_INHERIT
		bossChase3.set_physics_process(true)
		bossChase3.set_process(true)
		
		



func _on_animation_player_break_finished() -> void:
	fallingPiano.sprite.play("crash")
	#DIALOUGE BOXES HERE THAT WILL BE PLAYER TALKING TO DEFEATED BOSS??????
	get_tree().change_scene_to_file("res://Scenes/Main Menu/main_menu.tscn")


func _on_falling_piano_player_cutting_piano() -> void:
	print("AnimationPlayer please play")
	TheaterManager.pianoCutscene = true
	
	animationPlayer1.play("pianoFalling") 
