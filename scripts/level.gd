extends Node2D

@export var beattime:float = 0.75

@onready var grid: TileMapLayer = $Grid


const E_TROOP_SCENE = preload("res://troops/explode_troop.tscn")

var troop_list: Node2D

var path = []
# Called when the node enters the scene tree for the first time.

func _ready():
	#timer 
	var timer = Timer.new()
	timer.wait_time = beattime
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	
	troop_list = Node2D.new()
	add_child(troop_list)
	
	find_path()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_left"):
		spawn(1)
	if Input.is_action_just_pressed("ui_down"):
		activate(1)
	if Input.is_action_just_pressed("ui_right"):
		win()
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()

func spawn(type):
	var t 
	match type:
		1: t = E_TROOP_SCENE.instantiate()
	t.global_position = grid.local_to_map($Spawn.position)
	t.set_grid_and_path(grid,path)
	troop_list.add_child(t)
	
func activate(type):
	for t in troop_list.get_children():
		t.activate()
	
	
func _on_timer_timeout():
	for t in troop_list.get_children():
		t.move()

func get_towers():
	return $tower_list.get_children()
	
	
func find_path():
	path = []
	var current = grid.local_to_map($Spawn.position)
	while true:
		path.append(current)
		var targets = GridHelper.adjacent(current)
		var found_next = false
		
		for i in targets:
			if i not in path:
				var tile_data = grid.get_cell_tile_data(i)
				if tile_data != null and tile_data.get_custom_data("path"):
					current = i
					found_next = true
					break 
		
		if not found_next:
			break 
			
	print("Found path: ", path)
	return path
		
func win():
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level = current_scene_file.to_int() + 1
	if next_level != 10000:
		var next_level_path = "res://levels/level" + str(next_level) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
	
	
