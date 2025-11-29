extends Node2D

@export var speed = 100
@export var direction: int = 1
@export var horiztonal: bool = true
@onready var collison = $Area2D/CollisionShape2D

func _physics_process(delta: float) -> void:
	if(horiztonal):
		position.x += direction*speed*delta
	else:
		position.y -= speed*delta

func _ready() -> void:
	var shape_resource = collison.shape
	if(horiztonal):
		collison.shape.size.x = 124.067
		collison.shape.size.y = 843.373
		shape_resource = Vector2(124, 843)
	else:
		collison.position.x = 19.667 
		collison.position.y = -96.275
		shape_resource = Vector2(893, 90)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		CheckpointManager.load_saved_progression()
