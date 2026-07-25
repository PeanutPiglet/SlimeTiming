extends Node

@export var beattime:float = 0.75
var beat_counter = -1

const TOTAL_LEVELS:int = 20
var current_level:int = 0  # note: change to 1 for release
var active_level:GameLevel;

const END_SCREEN = "res://levels/end.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#timer 
	var timer = Timer.new()
	timer.wait_time = beattime
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	
	load_level("res://levels/level" + str(current_level) + ".tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout():
	beat_counter += 1
	if beat_counter % 4 == 0:  # music bar
		pass
	if beat_counter % 384 == 0:  # music length
		$BackgroundMusic.play()
	
	if active_level:
		active_level.beat()


func load_level(level_path: String):
	var level = load(level_path)
	if not level:
		print("Failed to load level at ", level_path)
		return
	if active_level:
		active_level.queue_free()
	
	var instance = level.instantiate()
	active_level = instance as GameLevel
	active_level.beattime = beattime
	var allowed_troops:Dictionary[int, bool] = {
		1: true,
		2: current_level >= 5 or current_level == 0,
		3: current_level >= 10 or current_level == 0,
		4: current_level >= 15 or current_level == 0
	}
	active_level.allowed_troops = allowed_troops
	active_level.win_host_callback = next_level
	active_level.restart_callback = restart_level
	
	add_child(active_level)
	
func restart_level():
	var next_level_path = "res://levels/level" + str(current_level) + ".tscn"
	load_level(next_level_path)
	
func next_level():
	current_level += 1
	if current_level <= TOTAL_LEVELS:
		var next_level_path = "res://levels/level" + str(current_level) + ".tscn"
		load_level(next_level_path)
	else:
		get_tree().change_scene_to_file(END_SCREEN)


		
