extends CharacterBody2D

var direction = 1 #Direction of spike wall movinf
var speed = 100 #How fast spike wall moves
var active: bool = false

func _ready() -> void:
	add_to_group("spikeWall")


func _physics_process(delta: float) -> void:
	
	if not active:
		$CollisionShape2D.disabled = true   # disable Collison while inactive
		return
	else:
		$CollisionShape2D.disabled = false   # enable Collison
	#Moves wall in direction
	velocity.x = direction*speed
	velocity.y = 0
	move_and_slide()
	
	#Stops wall if it is on a wall
	if(self.is_on_wall()):
		var collison = get_last_slide_collision()
		if collison and collison.get_collider() is TileMap:
			speed = 0
			velocity.x = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not active:
		return
	
	if(body.is_in_group('player')):
		CheckpointManager.load_saved_progression()
	
