# Sam Trout 9/16/25
# Camera with axis locking + deadzone + smooth follow

extends Camera2D

@export var player_path: NodePath
@export var follow_speed := 6.0
@export var deadzone_size := Vector2(32, 16)
var locked_position: Vector2 = Vector2.ZERO

# Camera follow modes
@export_enum("FULL_FOLLOW", "LOCKED", "VERTICAL_ONLY", "HORIZONTAL_ONLY") var follow_mode := "FULL_FOLLOW"

var player: Node2D

func _ready():
	if player_path != null:
		player = get_node(player_path)
	else:
		push_warning("Player path not assigned to Camera2D!")


func _process(delta):
	
	if player == null:
		return
		
	var target_position = global_position
	
	# If camera completely locked, do nothing
	if follow_mode == "LOCKED":
		global_position = global_position.lerp(locked_position, follow_speed * delta)
		return

	var offset = player.global_position - global_position
	var move = Vector2.ZERO

	# Horizontal follow?
	if follow_mode in ["FULL_FOLLOW", "HORIZONTAL_ONLY"]:
		if abs(offset.x) > deadzone_size.x / 2:
			move.x = offset.x - sign(offset.x) * deadzone_size.x / 2
	else:
		target_position.x = locked_position.x
	# Vertical follow?
	if follow_mode in ["FULL_FOLLOW", "VERTICAL_ONLY"]:
		if abs(offset.y) > deadzone_size.y / 2:
			move.y = offset.y - sign(offset.y) * deadzone_size.y / 2
	else:
		target_position.y = locked_position.y
	# Smooth follow
	target_position += move
	global_position = global_position.lerp(target_position, follow_speed * delta)

func matchPositionToPlayer():
	global_position = player.position
	
func set_zoom_smooth(target: Vector2, duration := 0.5):
	var tween := get_tree().create_tween()
	tween.tween_property(self, "zoom", target, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
