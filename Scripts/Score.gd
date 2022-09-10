extends Label


func _process(delta):
	text = "00" + String(Global.fruits)
	if Global.fruits >= 10:
		text = "0" + String(Global.fruits)
