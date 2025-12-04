extends AnimationPlayer

signal break_finished

func _ready():
	connect("animation_finished", Callable(self, "_on_anim_finished"))

func _on_anim_finished(anim_name):
	if anim_name == "pianoFalling":
		print("hi")
		emit_signal("break_finished")
