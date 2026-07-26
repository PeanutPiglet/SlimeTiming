extends Node

var furthest = 20
# Called when the node enters the scene tree for the first time.
var stars = {0:[false,false,false]}

func _ready():
	for i in range(1,21):
		stars[i] = [false,false,false]
	updateFurthest(0, [true,true,true])
	
func updateFurthest(lvl, arr):
	if lvl+1 > furthest:
		furthest = lvl+1
	for i in range(0,3):
		if stars[lvl][i] == false:
			if arr[i] == true:
				stars[lvl][i] = true
	
