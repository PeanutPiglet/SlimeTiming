extends Node2D

@export var beattime = 0.75

@onready var grid: TileMapLayer = $Grid

const E_TROOP_SCENE = preload("res://troops/explode_troop.tscn")

# Called when the node enters the scene tree for the first time.
var troop_list: Node2D
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_left"):
		spawn()
	if Input.is_action_just_pressed("ui_down"):
		activate_explode()

func spawn():
	var t = E_TROOP_SCENE.instantiate()
	t.global_position = $Spawn.position
	t.set_grid(grid)
	troop_list.add_child(t)

func _on_timer_timeout():
	for t in troop_list.get_children():
		t.move()
func activate_explode():
	for t in troop_list.get_children():
		t.activate()
func get_towers():
	return $tower_list.get_children()
