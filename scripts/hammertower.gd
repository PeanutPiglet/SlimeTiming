extends Tower

@export var damage: int = 2

func activate():
	print("HAMMER")
	$AnimatedSprite2D.play()
	$Timer.start()


func _on_timer_timeout() -> void:
	print("DOWN")
	for area in $Area2D.get_overlapping_areas():
		if area.is_in_group("troop_damageable"):
			var troop = area.get_parent() as Troop
			if troop:
				troop.take_damage(damage)
