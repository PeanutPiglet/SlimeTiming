class_name Booster_troop
extends Troop

func _ready():
	super._ready()
	
func activate():
	
	var troops = get_tree().current_scene.get_troops()
	var grid_pos = grid.local_to_map(position)
	var targets = GridHelper.three_by_three(grid_pos) + [grid_pos]
	for t:Troop in troops:
		if grid.local_to_map(t.position) in targets:
			t.boost()
	super.activate()
