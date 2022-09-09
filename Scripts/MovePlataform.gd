extends Node2D

onready var platform = $Platform
onready var tween = $Tween

export var speed = 3.0
export var horizontal = true
export var distance = 100

var follow = Vector2.ZERO
const WAIT_DURATION = 1.0

func _ready():
	_start_tween()

func _start_tween():
	var moveDirection = Vector2.RIGHT * distance if horizontal else Vector2.UP * distance
	var duration = moveDirection.length() / float(speed * 16)
	
	tween.interpolate_property(
		self, "follow", Vector2.ZERO, moveDirection, duration, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, WAIT_DURATION
	)
	
	tween.interpolate_property(
		self, "follow", moveDirection, Vector2.ZERO, duration, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + WAIT_DURATION * 2
	)
	
	tween.start()

func _physics_process(_delta):
	platform.position = platform.position.linear_interpolate(follow, 0.05)
