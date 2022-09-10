extends Area2D

func _ready():
	pass

func _on_CheckPoint_body_entered(body):
	if body.name == "Player":
		body.hitCheckPoint()
		$anim.play("Checked")
		$Collision.queue_free()
