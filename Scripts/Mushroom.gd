extends KinematicBody2D

export var speed = 64
export var health = 1
var velocity = Vector2()
var moveDirection = -1

func _physics_process(delta: float) -> void:
	velocity.x = speed * moveDirection
	
	velocity = move_and_slide(velocity)
	
	if moveDirection == 1:
		$texture.flip_h = true
	else:
		$texture.flip_h = false

	if $RayWall.is_colliding():
		$anim.play("Idle")


func _on_anim_animation_finished(anim_name):
	if anim_name == "Idle":
		$texture.flip_h != $texture.flip_h
		$RayWall.scale.x *= -1
		moveDirection *= -1
		$anim.play("Run")
