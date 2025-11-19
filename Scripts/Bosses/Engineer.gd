extends Node

# Get turrets loaded in
@onready var turret1 = $Turret
@onready var turret2 = $Turret2
@onready var turret3 = $Turret3
@onready var turret4 = $Turret4
@onready var turret5 = $Turret5
@onready var turret6 = $Turret6

@onready var animations = $AnimatedSprite2D

# variables
var turretBorken = false
var timeTillTurretBreaks = 0

#Boss states
enum BossState{
	Idle,
	Fix
}

#Default State
var current_state: BossState = BossState.Idle

func change_state(new_state: BossState):
	current_state = new_state
	match current_state:
		BossState.Idle:
			animations.play("Idle")
		BossState.Fix:
			animations.play("Fix")
			
			
func _physics_process(delta: float) -> void:
	
	pass
