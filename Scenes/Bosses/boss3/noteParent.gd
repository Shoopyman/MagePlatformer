extends Node2D

@onready var explosion = $explosion

func explode():
	explosion.emitting = true
