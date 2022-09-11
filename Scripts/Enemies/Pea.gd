extends Area2D

var velocity = Vector2.ZERO
var shootSpeed = -100

func _physics_process(delta):
	velocity.x = shootSpeed * delta
	
	translate(velocity)
