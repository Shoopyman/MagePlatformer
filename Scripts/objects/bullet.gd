extends Area2D

var direction: Vector2 = Vector2.ZERO
var speed := 400.0

func _physics_process(delta):
	global_position += direction * speed * delta
