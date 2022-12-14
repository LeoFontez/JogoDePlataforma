extends CanvasLayer


func changeScene(path, delay = 2.5):
	$transitionFx.interpolate_property($Overlay, "progress", 0.0, 1.0, 2.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT, delay)
	$transitionFx.start()
	yield($transitionFx, "tween_completed")
	assert(get_tree().change_scene(path) == OK)
