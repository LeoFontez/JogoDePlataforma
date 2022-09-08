extends Area2D

func _on_Items_body_entered(body):
	print(body.name)
	$anim.play("Collected")

func _on_anim_animation_finished(anim_name):
	if anim_name == "Collected":
		queue_free()
