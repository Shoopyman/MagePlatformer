extends Node2D

@onready var sign1 = $"Basic Control Sign/Label"
@onready var player = $Player
@onready var moveTest = $MoveText

var firstLoad = true

var moveTextDeleted = false

func _ready()->void:
	CheckpointManager.respawn_player()
	sign1.text = "To jump Press C\n"
	


func _on_despawn_sign_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if(body.is_in_group('player') && moveTextDeleted == false):
		moveTest.queue_free()
		moveTextDeleted = true
