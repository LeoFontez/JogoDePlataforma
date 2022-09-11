extends Area2D

onready var changer = get_parent().get_node("Transition_in")

export var path : String

func _ready():
	pass

func _on_Goal_body_entered(body):
	if body.name == "Player": 
		$Confetti.emitting = true
		$Animation.play("Caught")
		changer.changeScene(path)
		Global.checkPointPos = 0


func _on_Animation_animation_finished(anim_name):
	pass # Replace with function body.
