extends KinematicBody2D

var velocity = Vector2()
var moveSpeed = 480
var gravity = 1200
var jumpForce = -720
var isGrounded  
onready var raycasts = $Raycasts

func _physics_process(delta: float) -> void:

	velocity.y += gravity * delta

	_get_input()

	move_and_slide(velocity)

	isGrounded = _checkIsGround()
	
	_setAnimation()
	
func _get_input():
	velocity.x = 0
	var moveDirection = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))	
	velocity.x =lerp(velocity.x, moveSpeed * moveDirection, 0.2)
	
	if moveDirection != 0:
		$Texture.scale.x = moveDirection 

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and isGrounded:
		velocity.y = jumpForce / 2		

func _checkIsGround():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true	
	
	return false

func _setAnimation():
	var anim = "Idle"
	
	if !isGrounded:
		anim = "Jump"
	elif velocity.x != 0:
		anim = "Run"
	
	if $anim.assigned_animation != anim:
		$anim.play(anim)
