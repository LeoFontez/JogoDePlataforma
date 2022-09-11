extends enemyBase

func _process(delta):
	velocity.y = 0
	if $RayWall.is_colliding():
		$RayWall.scale.x *= -1
		moveDirection *= -1
		$anim.play("Run")
