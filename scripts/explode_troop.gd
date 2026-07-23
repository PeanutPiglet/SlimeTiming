class_name Explode_troop
extends Troop

@export var damage = 1

func _ready():
	super._ready()
	
func activate():
	var explosion = $SquareExplosion
	explosion.monitoring = true
	print(explosion.get_overlapping_areas())
	for body in explosion.get_overlapping_areas():
		var tower = body.get_parent() as Tower
		if tower and tower.is_in_group("tower_damageable"):
			tower.take_damage(damage)
	queue_free()
