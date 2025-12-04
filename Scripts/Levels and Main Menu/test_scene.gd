extends Node2D

@onready var player = $Player
@onready var KeyListener1 = $KeyListener
@onready var KeyListener2 = $KeyListener2
@onready var KeyListener3 = $KeyListener3

func _ready() -> void:
	$AnimatedSprite2D.play("Idle")


func _process(delta: float) -> void:
	if(player.hp <0):
		KeyListener1.falling_key_queue.clear()
		KeyListener2.falling_key_queue.clear()
		KeyListener3.falling_key_queue.clear()
		
		get_tree().reload_current_scene()
		
