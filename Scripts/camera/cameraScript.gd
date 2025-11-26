# Sam Trout 9/16/25
# Camera with axis locking + deadzone + smooth follow

extends Camera2D

@export var player_path: NodePath
@export var follow_speed := 6.0
@export var deadzone_size := Vector2(32, 16)

# Camera follow modes
enum FollowMode {
	FULL_FOLLOW,        # follow both axes
	LOCKED,             # don't follow at all
	VERTICAL_ONLY,      # follow Y, lock X
	HORIZONTAL_ONLY     # follow X, lock Y
}

@export var follow_mode: FollowMode = FollowMode.FULL_FOLLOW

var player: Node2D

func _ready():
	if player_path != null:
		player = get_node(player_path)
	else:
		push_warning("Player path not assigned to Camera2D!")


func _process(delta):
	if player == null:
		return

	# If camera completely locked, do nothing
	if follow_mode == FollowMode.LOCKED:
		return

	var offset = player.global_position - global_position
	var move = Vector2.ZERO

	# Horizontal follow?
	if follow_mode in [FollowMode.FULL_FOLLOW, FollowMode.HORIZONTAL_ONLY]:
		if abs(offset.x) > deadzone_size.x / 2:
			move.x = offset.x - sign(offset.x) * deadzone_size.x / 2

	# Vertical follow?
	if follow_mode in [FollowMode.FULL_FOLLOW, FollowMode.VERTICAL_ONLY]:
		if abs(offset.y) > deadzone_size.y / 2:
			move.y = offset.y - sign(offset.y) * deadzone_size.y / 2

	# Smooth follow
	var target_position = global_position + move
	global_position = global_position.lerp(target_position, follow_speed * delta)

func matchPositionToPlayer():
	global_position = player.position
