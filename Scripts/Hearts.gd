extends Control

#tamanho do sprite
var lifeSize = 32

func onChangeLife(playerHealth):
	$Life.rect_size.x = playerHealth * lifeSize
