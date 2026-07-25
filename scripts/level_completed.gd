extends Node

var furthest = 1
# Called when the node enters the scene tree for the first time.
var stars = {0:[false,false,false]}

func _ready():
	for i in range(1,21):
		stars[i] = [false,false,false]
	updateFurthest(0, [true,true,true])
	
func updateFurthest(lvl, arr):
	if lvl > furthest:
		furthest = lvl
	stars[lvl] = arr
	
