extends CharacterBody2D

@export var speed = 60
@export var accel = 2400
var direction = 1


func _physics_process(delta: float) -> void:
	velocity.x = move_toward(velocity.x, direction * speed, accel * delta)
	velocity.y = 0
	move_and_slide()
	if(self.is_on_wall()):
		direction *= -1
