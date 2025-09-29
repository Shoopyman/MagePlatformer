#Sam Trout 9/16/25
#courtesy of youtube !

extends Camera2D

@export var player_path: NodePath
@export var follow_speed := 6.0       # how fast the camera catches up
@export var pixels_per_unit := 16           # usually 1 for 1px = 1 world unit
@export var deadzone_size := Vector2(32, 16)

var player: Node2D

func _ready():
	if player_path != null:
		player = get_node(player_path)
	else:
		push_warning("Player path not assigned to Camera2D!")

func _process(delta):
	if player == null:
		return

	# --- Deadzone offset ---
	var offset = player.global_position - global_position
	var move = Vector2.ZERO

	if abs(offset.x) > deadzone_size.x / 2:
		move.x = offset.x - sign(offset.x) * deadzone_size.x / 2
	if abs(offset.y) > deadzone_size.y / 2:
		move.y = offset.y - sign(offset.y) * deadzone_size.y / 2

	# --- Smooth lerp ---
	var target_position = global_position + move
	global_position = global_position.lerp(target_position, follow_speed * delta)
