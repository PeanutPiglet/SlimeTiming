extends Tower

@export var targetDistance: Vector2i = Vector2i(1,0)

func _ready():
	super._ready()
	
	
func activate():
	
	var grid_pos = grid.local_to_map(position)
	var target = grid_pos + targetDistance
	print(target)
	$firesprite.position = grid.map_to_local(targetDistance)
	$firesprite.visible = true
	await get_tree().create_timer(0.25).timeout
	for t in get_tree().current_scene.get_troops():
		if grid.local_to_map(t.position) == target:
			
			print("hit")
	
func increment(i:int):
	$firesprite.visible = false
	super.increment(i)
	
