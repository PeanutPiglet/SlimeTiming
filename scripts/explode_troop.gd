class_name Explode_troop
extends Troop

@export var damage = 1

func _ready():
	super._ready()
	
func activate():
	var explosion = $SquareExplosion
	explosion.monitoring = true
	print(explosion.get_overlapping_areas())
	for area in explosion.get_overlapping_areas():
		var tower = area.get_parent() as Tower
		if tower and area.is_in_group("tower_damageable"):
			tower.take_damage(damage)
	queue_free()
