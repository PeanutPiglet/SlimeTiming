class_name Troop
extends Node2D

var moveable = false
var grid:TileMapLayer
var path:Array
var movespeed = 1
var path_progress = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	#slight delay before can move
	await get_tree().create_timer(0.25).timeout
	moveable = true
	
func set_grid_and_path(_grid, _path):
	grid = _grid
	path = _path
	position = grid.map_to_local(path[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
		
func move():
	if moveable:
		for i in range(movespeed):
			path_progress += 1
			if path_progress >= len(path):
				print(2)
				queue_free()
			else:
				position = grid.map_to_local(path[path_progress])
			
		
		
func active(): 
	pass
