extends Tower

@export var targetDistance: Vector2i = Vector2i(1,0)

func _ready():
	super._ready()
	
func activate():
	
	var grid_pos = grid.local_to_map(position)
	var target = grid_pos + targetDistance
	
	
func increment(i:int):
	super.increment(i)
