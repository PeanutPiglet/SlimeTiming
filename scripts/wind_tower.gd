extends Tower

var windproj = load("res://towers/projectiles/wind.tscn")

@export var angles: Array[float] = [0.0]

func activate():
	for angle in angles:
		var proj = windproj.instantiate()
		proj.global_position = $Center.global_position
		proj.rotation = deg_to_rad(angle)
		get_tree().current_scene.add_child(proj)
