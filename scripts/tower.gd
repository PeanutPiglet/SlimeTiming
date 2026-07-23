@abstract class_name Tower
extends Node

@export var health = 1


@abstract func activate()
	
func take_damage(d:int):
	health -= d
	if health <= 0:
		queue_free()
