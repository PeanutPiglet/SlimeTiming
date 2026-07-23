extends Node

var furthest = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	updateFurthest()
	
func updateFurthest():
	var current = get_tree().current_scene.scene_file_path
	if(current.to_int() is int):
		current= current.to_int()
		
	if(current is int && furthest<current):
		furthest = current
