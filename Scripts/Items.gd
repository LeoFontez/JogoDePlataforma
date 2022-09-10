extends Area2D

export var fruits = 1

func _on_Items_body_entered(body):
	$anim.play("Collected")
	Global.fruits += fruits
	
func _on_anim_animation_finished(anim_name):
	if anim_name == "Collected":
		queue_free()
