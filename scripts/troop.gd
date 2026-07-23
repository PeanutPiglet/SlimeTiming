class_name Troop
extends Node2D

var moveable = false
var grid:TileMapLayer
var path:Array
@export var movespeed:float = 1
@export var health = 3

var path_progress = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#slight delay before can move
	await get_tree().create_timer(0.25).timeout
	moveable = true
	
func set_grid_and_path(_grid, _path):
	grid = _grid
	path = _path
	position = grid.map_to_local(path[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
		
func move():
	if moveable:
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
func move_animation(target_pos):
	var tween = create_tween()
	tween.tween_property(self, "position", target_pos, 0.2)\
		 .set_trans(Tween.TRANS_SINE)\
		 .set_ease(Tween.EASE_OUT)

func take_damage(d:int):
	health -= d
	if health <= 0:
		queue_free()


func active(): 
	pass
