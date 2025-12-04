extends Node

# Get turrets loaded in
@onready var turret1 = $Turret
@onready var turret2 = $Turret2
@onready var turret3 = $Turret3
@onready var turret4 = $Turret4
@onready var turret5 = $Turret5
@onready var turret6 = $Turret6

@onready var hitbox = $Area2D/CollisionShape2D
@onready var animations = $Area2D/AnimatedSprite2D
@onready var area = $Area2D


signal boss_defeated

# variables
var bossPhase = 0
var timeTillTurretBreaks = 10
var timePassed = 0
var fixTime = 0
var bossDefeated = false
var bossAttacked = false
var hasMoved = false
var brokenTuret = null
var isDefeated = false

#Boss states
enum BossState{
	Idle,
	Fix
}

#Default State
var current_state: BossState = BossState.Idle

#Chnage between states for boss AI
func change_state(new_state: BossState) -> void:
	current_state = new_state
	match current_state:
		BossState.Idle:
			$Area2D/AnimatedSprite2D.play("Idle")
		BossState.Fix:
			$Area2D/AnimatedSprite2D.play("Idle")
			
			
			
func _process(delta: float) -> void:
	if(timePassed > timeTillTurretBreaks):
		
		if(bossPhase == 0):
			brokenTuret = turret1
			
			brokenTuret.change_state(brokenTuret.TurretState.Broken)
			change_state(BossState.Fix)
		elif(bossPhase == 1):
			brokenTuret = turret2
			brokenTuret.change_state(brokenTuret.TurretState.Broken)
			change_state(BossState.Fix)
		elif (bossPhase == 2):
			brokenTuret = turret6
			brokenTuret.change_state(brokenTuret.TurretState.Broken)
			change_state(BossState.Fix)
	timePassed += delta
	fixTurret(delta)

#Move to fix the turret 
func fixTurret(delta: float):
	if (current_state != BossState.Fix):
		return
	if(hasMoved == false):
		hitbox.disabled = false
		area.global_position.x = brokenTuret.global_position.x+10
		area.global_position.y = brokenTuret.global_position.y
		hasMoved = true
		
	fixTime += delta
	#Checks to see if enough time to fix turret has passed
	if (fixTime > 10):
		fixTime = 0
		hasMoved = false
		hitbox.disabled = true
		timePassed = 0
		change_state(BossState.Idle)
		brokenTuret.change_state(brokenTuret.TurretState.Recharging)
	
	if(bossAttacked):
		bossPhase += 1
		
		#Need to space out so hurt animations fully plays 
		#
		#
		#Activate or set boss as defeated depending on value
		checkPhase(bossPhase)
		#animations.play('hurt')
		bossAttacked = false
		hasMoved = false
		fixTime = 0
		hitbox.disabled = true
		brokenTuret.change_state(brokenTuret.TurretState.Recharging )
		timePassed = 0
		timeTillTurretBreaks += 2
		change_state(BossState.Idle)
		

#On load, hide every turret but the bottom two
func _ready() -> void:
	#Hide every turret but the two on the floor
	turret2.hide()
	turret2.raycast.enabled = false
	turret2.set_process(false)
	turret2.set_physics_process(false)
	
	turret4.hide()
	turret4.raycast.enabled = false
	turret4.set_process(false)
	turret4.set_physics_process(false)
	
	turret5.hide()
	turret5.raycast.enabled = false
	turret5.set_process(false)
	turret5.set_physics_process(false)
	
	turret6.hide()
	turret6.raycast.enabled = false
	turret6.set_process(false)
	turret6.set_physics_process(false)
	hitbox.disabled = true
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group('player')):
		if(body.is_dashing()):
			bossAttacked = true
			
func checkPhase(phase: int):
	if(phase == 1):
		turret2.show()
		turret2.raycast.enabled = true
		turret2.set_process(true)
		turret2.set_physics_process(true)
		
		turret4.show()
		turret4.raycast.enabled = true
		turret4.set_process(true)
		turret4.set_physics_process(true)
	elif(phase == 2):
		turret5.show()
		turret5.raycast.enabled = true
		turret5.set_process(true)
		turret5.set_physics_process(true)
		
		turret6.show()
		turret6.raycast.enabled = true
		turret6.set_process(true)
		turret6.set_physics_process(true)
	else:
		
		isDefeated = true
		emit_signal("boss_defeated")
