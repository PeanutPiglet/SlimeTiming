class_name Explode_troop
extends Troop

var fx_explosion = preload("res://common/fx_explosion.tscn")

func _ready():
	super._ready()
	
func activate():
	super.activate()
	var explosion = $SquareExplosion
	explosion.monitoring = true
	print(explosion.get_overlapping_areas())
	for area in explosion.get_overlapping_areas():
		var tower = area.get_parent() as Tower
		if tower and area.is_in_group("tower_damageable"):
			tower.take_damage(damage)
	
	var fx = fx_explosion.instantiate()
	fx.global_position = global_position
	get_tree().current_scene.add_child(fx)
	
	queue_free()
