extends Node2D

@export var beattime:float = 0.75

@onready var grid: TileMapLayer = $Grid

const TOTAL_LEVELS = 2

const E_TROOP_SCENE = preload("res://troops/explode_troop.tscn")
const D_TROOP_SCENE = preload("res://troops/defense_troop.tscn")
const B_TROOP_SCENE = preload("res://troops/booster_troop.tscn")

const END_SCREEN = "res://levels/end.tscn"

var troop_list: Node2D

var path = []
var counting = false
var time_counter = 0
var spawn_counter = 0
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
	
	if Input.is_action_pressed("active"):
		if Input.is_action_just_pressed("spawn1"):
			activate(1)
		if Input.is_action_just_pressed("spawn2"):
			activate(2)
		if Input.is_action_just_pressed("spawn3"):
			activate(3)
	else:
		if Input.is_action_just_pressed("spawn1"):
			spawn(1)
		if Input.is_action_just_pressed("spawn2"):
			spawn(2)
		if Input.is_action_just_pressed("spawn3"):
			spawn(3)
			
	
	if Input.is_action_just_pressed("ui_down"):
		activate(1)
	if Input.is_action_just_pressed("ui_right"):
		win()
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()

func spawn(type):
	for i in get_troops():
		if grid.local_to_map(i.position) == grid.local_to_map($Spawn.position):
			if (i.overlap):
				return
	var t 
	match type:
		1: t = E_TROOP_SCENE.instantiate()
		2: t = D_TROOP_SCENE.instantiate()
		3: t = B_TROOP_SCENE.instantiate()
	t.global_position = grid.local_to_map($Spawn.position)
	t.init(grid,path,beattime)
	troop_list.add_child(t)
	spawn_counter += 1 
	if(!counting):
		await get_tree().create_timer(0.25).timeout
		counting = true
	
func activate(type):
	
		
	for t in troop_list.get_children():
		var correct = false
		match type:
			1: correct = t is Explode_troop
			2: correct = t is Defense_troop
			3: correct = t is Booster_troop
		if correct:
			t.activate()
	
	
func _on_timer_timeout():
	for t in get_troops():
		t.move()
	
	for to in get_towers():
		if to is Tower:
			to.increment(1)
	
	if len(get_towers()) <= 0:
		win()
	if counting:
		time_counter += 1
	print("time:", time_counter, "spawn:", spawn_counter)

func get_towers():
	return $tower_list.get_children()
func get_troops():
	return troop_list.get_children()
func get_grid():
	return grid
	
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
			
	return path

func win():
	print("time:", time_counter, "spawn:", spawn_counter)
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level = current_scene_file.to_int() + 1
	if next_level < TOTAL_LEVELS:
		var next_level_path = "res://levels/level" + str(next_level) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
	else:
		get_tree().change_scene_to_file(END_SCREEN)
	
	
