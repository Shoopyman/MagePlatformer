extends StaticBody2D

@export var rope_length: float = 64.0   # distance from rope pivot to platform
@onready var rope = $"../Crane-Chain"

func _process(delta):
	# Rope angle from animation
	var angle = rope.rotation

	# Position platform at the rope's end
	global_position = rope.global_position + Vector2(0, rope_length).rotated(angle)

	# Keep platform level
	rotation = 0
