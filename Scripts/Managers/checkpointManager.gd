extends Node

@export var default_spawn_position: Vector2 
var current_checkpoint_position: Vector2

func _ready() -> void:
	current_checkpoint_position = default_spawn_position

#Set position of respawn point to checkpoint crossed
func set_checkpoint(pos: Vector2) -> void:
	print("Checkpoint set to:", pos)
	current_checkpoint_position = pos
	
#Respawn player back to checpoint position if player object dies.
func respawn_player() -> void:
	var player = get_tree().get_nodes_in_group("player").front()
	if player:
		player.global_position = current_checkpoint_position

func reset_to_default():
	print("Checkpoint reset to default:", default_spawn_position)
	current_checkpoint_position = default_spawn_position
