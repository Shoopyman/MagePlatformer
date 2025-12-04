extends Node2D

var player_inside: Node2D = null
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	sprite.play("Idle")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player_inside = body
		print("player inside")
		_check_break() # Replace with function body.
		
		
func _check_break() -> void:
	print(player_inside.is_dashing())
	if player_inside and player_inside.is_dashing():
		print("piano broke")
		emit_signal("pianoBroke") #NEED HELP FROM SAM
		player_inside.velocity = Vector2.ZERO
		sprite.play("break")
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("player")):
		player_inside = null
