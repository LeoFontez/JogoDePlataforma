extends CanvasLayer


func _ready():
	$transitionFx.interpolate_property($Overlay, "progress", 1.0, 0.0, 2.0, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	$transitionFx.start()
