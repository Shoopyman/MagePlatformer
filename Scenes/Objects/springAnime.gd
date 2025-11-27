extends AnimatedSprite2D

# reference to the parent spring node
@onready var spring_node = get_parent()

func _ready():
	# connect frame_changed signal
	self.frame_changed.connect(_on_frame_changed)

func _on_frame_changed():
	if animation != "Action":
		return

	# trigger bounce on frame 1 (for example)
	if frame == 1:
		spring_node.spring_bounce()

	# reset on last frame
	if frame == 5:
		spring_node.spring_reset()
