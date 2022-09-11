extends KinematicBody2D

var facingLeft = true

onready var bulletInstance = preload("res://Scenes/Pea.tscn")
onready var player = Global.get("Player")

func _physics_process(delta: float) -> void:
	if player:
		var distance = player.global_position.x - self.position.x
		facingLeft = true if distance < 0 else false
		
	if facingLeft == true:
		self.scale.x = 1
	else:
		self.scale.x = -1

func shoot():
	var bullet = bulletInstance.instance()
	add_child(bullet)
	bullet.global_position = $SpawnShoot.global_position

func _on_PlayerDetector_body_entered(body: Node) -> void:
	$Animation.play("Attack")


func _on_PlayerDetector_body_exited(body):
	$Animation.play("Idle")
