extends Node2D

# Hookes law variables
@export var rest_length = 100.0
@export var stiffness = 10.0
@export var damping = 2.0

@onready var player := get_parent()
@onready var ray = $RayCast2D
@onready var rope = $Line2D

var grapple_available = true
var launched = false
var target: Vector2

func _process(delta):
	ray.look_at(get_global_mouse_position())
	global_position = player.global_position
	if Input.is_action_just_pressed("hook"):
		launch(player)
	if Input.is_action_just_released("hook"):
		retract()
	if launched:
		handle_grapple(player, delta)
		
func launch(player):
	if ray.is_colliding():
		print("Clarinet Show")
		launched = true
		target = ray.get_collision_point()
		rope.show()
		
		
func retract():
	print("Clarinet Hide")
	launched = false
	rope.hide()
	
func handle_grapple(player, delta):
	print("Clarinet")
	var target_dir = player.global_position.direction_to(target) 
	var target_dist = player.global_position.distance_to(target) 	
	var displacement = target_dist - rest_length
	
	var force = Vector2.ZERO
	
	
	if displacement > 0:
		print("Displacment greater than zero")
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_dir* spring_force_magnitude
		
		var vel_dot = player.velocity.dot(target_dir)
		var damping = -damping * vel_dot * target_dir
		
		force = spring_force + damping
		
		if target_dir.x > 0:
			force.x += 1000  # Boost right
		elif target_dir.x < 0:
			force.x -= 500  # Less boost left
	
	player.velocity += force * delta
	update_rope(player)
	
func update_rope(player):
	rope.set_point_position(1, to_local(target))
