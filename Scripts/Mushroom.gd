extends KinematicBody2D

export var speed = 32
export var health = 1
var velocity = Vector2()
var moveDirection = -1
var gravity = 1200
var hitted = false

func _physics_process(delta: float) -> void:
	velocity.x = speed * moveDirection
	velocity.y += gravity * delta
	
	if moveDirection == 1:
		$texture.flip_h = true
	else:
		$texture.flip_h = false
	
	_setAnimation()
	
	velocity = move_and_slide(velocity)
	
func _setAnimation():
	var anim = "Run"
	
	if $RayWall.is_colliding():
		anim = "Idle"
	elif velocity.x != 0:
		anim = "Run"
	
	if hitted == true:
		anim = "Hit"
		
	if $anim.assigned_animation != anim:
		$anim.play(anim)

func _on_anim_animation_finished(anim_name):
	if anim_name == "Idle":
		$RayWall.scale.x *= -1
		moveDirection *= -1
		$anim.play("Run")


func _on_HitBox_body_entered(body: Node) -> void:
	hitted = true
	health -= 1
	body.velocity.y = body.jumpForce / 2
	yield(get_tree().create_timer(0.2), "timeout")
	hitted  = false
	
	if health < 1:
		queue_free()
		get_node("HitBox/Collision").set_deferred("disabled", true)
