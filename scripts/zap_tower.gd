extends Tower

var towerproj = load("res://towers/projectiles/zap.tscn")

@export var angles: Array[float] = [0.0]

func activate():
	for angle in angles:
		var proj = towerproj.instantiate()
		proj.global_position = $Center.global_position
		proj.rotation = deg_to_rad(angle)
		get_tree().current_scene.add_child(proj)
