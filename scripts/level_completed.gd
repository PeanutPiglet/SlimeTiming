extends Node

var furthest = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	updateFurthest()
	
func updateFurthest():
	var current = get_tree().current_scene.current_level
	if(current is int && furthest<current):
		print("CHECKPOINT ", current)
		furthest = current
