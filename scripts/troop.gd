class_name Troop
extends Node2D

var fx_explosion = preload("res://common/fx_explosion.tscn") 

var moveable = false
var overlap = true
var grid:TileMapLayer
var path:Array
var beattime:float
@export var movespeed:float = 1
@export var damage = 1
@export var health = 3
@export var destroy_on_death = true
@export var activate_name = "explode"

var path_progress = 0
var pause_counter = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	
	#slight delay before can move
	await get_tree().create_timer(0.25).timeout
	moveable = true
	$AnimatedSprite2D.top_level = true
	$AnimatedSprite2D.position = position 
	
func init(_grid, _path,_beattime ):
	grid = _grid
	path = _path
	beattime = _beattime
	position = grid.map_to_local(path[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
		
func move():
	if pause_counter > 0:
		pause_counter -= 1
		return
	if moveable:
		$AnimatedSprite2D.modulate.a -=0.20
		if movespeed >= 1:
			for i in range(movespeed):
				path_progress += 1
				if floor(path_progress) >= len(path):
					print(2)
					queue_free()
				else:
					move_animation(grid.map_to_local(path[path_progress]))
		else: 
			path_progress += movespeed 
			if floor(path_progress) >= len(path):
				print(2)
				queue_free()
			else:
				move_animation(grid.map_to_local(path[path_progress]))
		overlap = false
		for a in ability_counters:
			if ability_counters[a] >= 1:
				ability_counters[a] -= 1
				if ability_counters[a] <= 0:
					var str = a + "_over"
					call(str)
		
	else:
		await get_tree().create_timer(0.5).timeout
		overlap = false
	
func move_animation(target_pos):
	global_position = target_pos
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D, "global_position", target_pos, 0.05)\
		 .set_trans(Tween.TRANS_CUBIC)\
	 	.set_ease(Tween.EASE_IN_OUT)

func take_damage(d:int):
	if ability_counters["defense"] > 0:
		return
	health -= d
	print("health: " + str(health))
	if health <= 0:
		on_death()
		if destroy_on_death:
			queue_free()
			
func pause_increment(delta: int):
	pause_counter += delta
		
func on_death():
	pass
#troop ability procs
var ability_counters = {"defense": 0, "boost": 0}

func defense():
	ability_counters["defense"] = 4
	print("defended!")
	$AnimatedSprite2D.modulate.a = 1
func boost():
	ability_counters["boost"] = 4
	print("boosted!")
	damage = 2
	$AnimatedSprite2D.modulate.a = 1

func defense_over():
	print("defend over")
	
	pass
func boost_over():
	print("boost over")
	damage = 1

func activate():
	var fx = fx_explosion.instantiate()
	fx.global_position = global_position
	fx.play(activate_name)
	get_tree().current_scene.add_child(fx)
	queue_free()
