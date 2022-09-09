extends KinematicBody2D

onready var anim = $Anim
onready var timer = $Timer

onready var resetPosition = global_position

var velocity = Vector2.ZERO
var gravity = 720
var isTriggered = false
export var resetTimer = 3.0

func _ready():
	set_physics_process(false)

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	position += velocity * delta
	
func collide_with(collision: KinematicCollision2D, collider: KinematicBody2D):
	if !isTriggered:
		isTriggered = true
		anim.play("shake")
		velocity = Vector2.ZERO

func _on_Anim_animation_finished(anim_name: String) -> void:
	set_physics_process(true)
	timer.start(resetTimer)

func _on_Timer_timeout():
	set_physics_process(false)
	yield(get_tree(), "physics_frame")
	var temp = collision_layer
	collision_layer = 0
	global_position = resetPosition
	yield(get_tree(), "physics_frame")
	collision_layer = temp
	isTriggered = false
