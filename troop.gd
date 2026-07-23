extends Node2D

var moveable = false
var grid:TileMapLayer
# Called when the node enters the scene tree for the first time.
func _ready():
	#slight delay before can move
	await get_tree().create_timer(0.25).timeout
	moveable = true

func set_grid(_grid):
	grid = _grid

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
		
func move():
	if moveable:
		position.x += 64
		print(grid.local_to_map(position))
