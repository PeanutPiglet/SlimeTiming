@abstract class_name Tower
extends Node2D

	

@export var health = 1
@export var destroy_on_death = true
@export var actionthreshold = 4
@export var actioncounter = 0
var grid:TileMapLayer

	
@abstract func activate()
	
	
func _ready():

	#everythign else here
	
	await get_tree().current_scene.ready
	grid = get_tree().current_scene.get_grid()
	
func take_damage(d:int):
	health -= d
	if health <= 0:
		on_death()
		if destroy_on_death:
			queue_free()
		
func on_death():
	pass

func increment(i:int):
	actioncounter += i
	if actioncounter >= actionthreshold:
		actioncounter -= actionthreshold
		activate()
