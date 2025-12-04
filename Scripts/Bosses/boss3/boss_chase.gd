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
	print(horiztonal)

func _ready() -> void:
	collison.shape = collison.shape.duplicate()
	print(horiztonal)
	if(horiztonal):
		collison.shape.size.x = 48.511
		collison.shape.size.y = 500.312
		collison.position.x = 48.511
		collison.position.y = 67.393
	elif not horiztonal:
		collison.position.x = 19.667 
		collison.position.y = -00.275
		collison.shape.size.x = 892.866
		collison.shape.size.y = 89.857


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		CheckpointManager.load_saved_progression()
