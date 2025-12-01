extends Node2D

enum TurretState{
	Scanning,
	Attack,
	Recharging,
	Broken
}

#Duration for Attack/Recharge
@export var fire_timer = .7
@export var recharge_time = 2.5
@export var fire_interval = .2

#Vars for bullets
@export var bullet_scene: PackedScene
@export var bullet_speed := 250.0

#Grab refrences to nodes needed

@onready var animations = $Animations
@onready var raycast = $TurretHead/RayCast2D
@onready var line = $TurretHead/Line2D
@onready var turretHead = $TurretHead

#Var for if player dashed into turrets
var player_inside: Node2D = null

#Default State  
var current_state: TurretState = TurretState.Scanning
var state_timer: float = 5.0

#Function to change between the states of the turrets
func change_state(new_state: TurretState):
	current_state = new_state
	match current_state:
		TurretState.Scanning:
			animations.play('scanning')
			line.visible = true
		TurretState.Attack:
			animations.play('attack')
			state_timer = fire_timer
			line.visible = false
		TurretState.Recharging:
			animations.play('recharging')
			state_timer = recharge_time
			line.visible= false
		TurretState.Broken:
			pass
			animations.play('broken')
			# Maybe need state timer here


func _physics_process(_delta: float) -> void:
	if current_state != TurretState.Scanning:
		return
	
	# Fire when the Player intersects the raycast.
	var collider = raycast.get_collider()
	if collider and collider.is_in_group('player'):
		print("Ready to fire Bullets physcis process")
		change_state(TurretState.Attack)

# Count down the timers and transition states when appropriate
func _process(delta: float) -> void:
	match current_state:
		TurretState.Attack:
			fire_timer -= delta
			if fire_timer <= 0.0:
				fireBullets()
				fire_timer = fire_interval

			state_timer -= delta
			if state_timer <= 0.0:
				change_state(TurretState.Recharging)
				fire_timer = 0.0  # reset for next Attack
		TurretState.Recharging:
			state_timer -= delta
			if state_timer <= 0.0:
				change_state(TurretState.Scanning)
		TurretState.Broken:
			print("Broken Turret")

#Fires bullets at player's position when collied with raycast
func fireBullets():
	var collider = raycast.get_collider()
	if collider == null:
		return
	if not collider.is_in_group('player') or not collider.is_in_group('movingPlatform') :
		return
	if collider is TileMapLayer:
		return
	
	# Get player position  when collided with raycast
	var target_pos = collider.global_position
	print("Ready to fire Bullets ACTUALLY FR")
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = turretHead.global_position
	
	# Get direction to fire toward
	var direction = (target_pos - global_position).normalized()

	# Tell bullet what direction to move
	bullet.direction = direction
	bullet.speed = bullet_speed
	
	print("Bullet going this direction")

func _ready() -> void:
	$Animations.play("scanning")
		
