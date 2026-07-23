@abstract class_name Tower
extends Node

@export var health = 1
@export var destroy_on_death = true

@abstract func activate()
	
func take_damage(d:int):
	health -= d
	if health <= 0:
		on_death()
		if destroy_on_death:
			queue_free()

func on_death():
	pass
