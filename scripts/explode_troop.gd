class_name Explode_troop
extends Troop

func _ready():
	super._ready()
	
func activate():
	var explosion = $SquareExplosion
	explosion.monitoring = true
	print(explosion.get_overlapping_bodies())
	for body in explosion.get_overlapping_bodies():
		body.queue_free()
	queue_free()
