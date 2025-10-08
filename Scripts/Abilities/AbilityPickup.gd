extends Area2D

@export var ability_name := "trombone"  # use "trombone" or "cymbals"
@export var float_height := 4.0
@export var float_speed := 2.0

var base_y = 0.0
var time = 0.0
var sprite: AnimatedSprite2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	base_y = position.y
	sprite = $AnimatedSprite2D
	sprite.play("Idle")

func _process(delta):
	time += delta
	position.y = base_y + sin(time*float_speed)*float_height

func _on_body_entered(body):
	# Option A: check for group "player"
	if body.is_in_group("player"):
		var am = body.get_node("AbilityManager") if body.has_node("AbilityManager") else null
		if am:
			am.unlock(ability_name)
			queue_free()
