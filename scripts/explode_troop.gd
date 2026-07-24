class_name Explode_troop
extends Troop

func _ready():
	super._ready()
	
func activate():
	var explosion = $SquareExplosion
	explosion.monitoring = true
	print(explosion.get_overlapping_areas())
	for body in explosion.get_overlapping_areas():
		var tower = body.get_parent()
		if tower.is_in_group("tower_damageable"):
			tower.queue_free()
	queue_free()
