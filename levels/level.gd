extends Node2D

@export var beattime = 0.75

@onready var grid: TileMapLayer = $Grid

const TROOP_SCENE = preload("res://troops/troop.tscn")

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

func spawn():
	var t = TROOP_SCENE.instantiate()
	t.global_position = Vector2(96,96)
	t.set_grid(grid)
	troop_list.add_child(t)

func _on_timer_timeout():
	print(1)
	for t in troop_list.get_children():
		t.move()
