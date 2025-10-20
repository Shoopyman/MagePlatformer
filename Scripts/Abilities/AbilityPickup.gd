extends Area2D

@export var ability_name := ""            # e.g. "trombone", "cymbals", "bongos"
@export var float_height := 4.0
@export var float_speed := 2.0
@export var respawn_time := 3.0           # seconds before the pickup reappears

var base_y: float
var time: float = 0.0
var sprite: AnimatedSprite2D
var respawning := false

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

func _on_body_entered(body: Node2D) -> void:
	if respawning or not body.is_in_group("player"):
		return

	var am = body.get_node("AbilityManager") if body.has_node("AbilityManager") else null
	if am:
		print("Unlocking Ability:", ability_name)
		am.unlock(ability_name, body)
	else:
		print("ERROR: Player missing AbilityManager")

	# Hide and disable for a few seconds, then respawn
	respawning = true
	visible = false
	if has_node("CollisionShape2D"):
		$CollisionShape2D.disabled = true

	await get_tree().create_timer(respawn_time).timeout

	visible = true
	if has_node("CollisionShape2D"):
		$CollisionShape2D.disabled = false
	respawning = false
