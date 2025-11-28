extends Area2D

@export var float_height := 4.0
@export var float_speed := 2.0
@export var respawn_time := 3.0           # seconds before the pickup reappears

var base_y: float
var time: float = 0.0
var sprite: AnimatedSprite2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	base_y = position.y
	sprite = $AnimatedSprite2D
	if sprite is AnimatedSprite2D:
		if "Idle" in sprite.sprite_frames.get_animation_names():
			sprite.play("Idle")
			
func _process(delta):
	time += delta
	position.y = base_y + sin(time * float_speed) * float_height
	
