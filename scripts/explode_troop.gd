class_name Explode_troop
extends Troop

func _ready():
	super._ready()
	
func activate():
	var towers = get_tree().current_scene.get_towers()
	print(towers)
	for to in towers:
		var grid_pos = grid.local_to_map(position)
		var targets = [grid_pos + Vector2i(1,0), grid_pos + Vector2i(-1,0), grid_pos + Vector2i(0,1), grid_pos + Vector2i(0,-1)]
		if grid.local_to_map(to.position) in targets:
			print(1)
			to.queue_free()
	queue_free()
