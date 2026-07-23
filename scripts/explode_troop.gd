class_name Explode_troop
extends Troop

func _ready():
	super._ready()
	
func activate():
	var explosion = $SquareExplosion
	explosion.monitoring = true
	print(explosion.get_overlapping_areas())
	for body in explosion.get_overlapping_areas():
		body.queue_free()  # right now this is deleting the area2D
	queue_free()
