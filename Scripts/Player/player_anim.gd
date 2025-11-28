extends AnimatedSprite2D

var anim := "default"

func animate(player):
	flip_h = 0
	anim = "default"
	
	if player.oneOff:
		return
	
	flip_h = player.facing_direction < 0
	
	if player.velocity.x != 0 and player.velocity.y == 0:
		anim = "running"
	elif player.velocity.y > 0:
		anim = "falling"
	elif player.velocity.y < 0:
		anim = "jumping"
	
	self.play(anim)
