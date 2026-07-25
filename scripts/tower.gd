@abstract class_name Tower
extends Node2D

	
var fx_explosion = preload("res://common/fx_explosion.tscn")  
@export var health = 1
@export var destroy_on_death = true
@export var actionthreshold = 4
@export var actioncounter = 0
@export var wincon = false
var og_health = health
var dead = false
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
	if health >= 1:
		$AnimatedSprite2D.play(str(health))
		
func on_death():
	var fx = fx_explosion.instantiate()
	fx.global_position = global_position + Vector2(32,32)
	fx.play("tower")
	get_tree().current_scene.add_child(fx)
	queue_free()

func increment(i:int):
	if dead:
		return
	actioncounter += i
	if actioncounter >= actionthreshold:
		actioncounter -= actionthreshold
		activate()
