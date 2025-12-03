extends Node2D

@onready var explosion = $explosion

func explodeNote():
	explosion.emitting = true
