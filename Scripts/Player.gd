extends KinematicBody2D

var UP = Vector2.UP
var velocity = Vector2()
var moveSpeed = 480
var gravity = 1200
var jumpForce = -720
var isGrounded  

var playerHealth = 3
var maxHealth = 3

var hurted = false

var knockbackDir = 1
var knockbackInten = 500

onready var raycasts = $Raycasts

signal changeLife(playerHealth)

func _ready():
	connect("changeLife", get_parent().get_node("HUD/HBoxContainer/Hearts"), "onChangeLife")
	emit_signal("changeLife", maxHealth)
	position.x = Global.checkPointPos + 50

func _physics_process(delta: float) -> void:

	velocity.y += gravity * delta
	velocity.x = 0
	
	if !hurted:
		_get_input()

	move_and_slide(velocity, UP)

	isGrounded = _checkIsGround()
	
	_setAnimation()
	
	for plataforms in get_slide_count():
		var collision = get_slide_collision(plataforms)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision, self)
	
func _get_input():
	velocity.x = 0
	var moveDirection = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))	
	velocity.x =lerp(velocity.x, moveSpeed * moveDirection, 0.2)
	
	if moveDirection != 0:
		$Texture.scale.x = moveDirection 
		knockbackDir = moveDirection
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
	if velocity.y > 0 and !isGrounded:
		anim = "Fall"
	
	if hurted == true:
		anim = "Hit"
		
	if $anim.assigned_animation != anim:
		$anim.play(anim)

func knockback():
	velocity.x = -knockbackDir * knockbackInten
	velocity = move_and_slide(velocity)

func _on_HurtBox_body_entered(body):
	
	playerHealth -= 1
	hurted = true
	emit_signal("changeLife", playerHealth)
	knockback()
	get_node("HurtBox/Collision").set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("HurtBox/Collision").set_deferred("disabled", false)
	hurted = false
	
	if playerHealth < 1:
		queue_free()
		get_tree().reload_current_scene()

func hitCheckPoint():
	Global.checkPointPos = position.x
