extends Node

@export var beattime:float = 0.75
var beat_counter = -1
var has_timer_began = false

const TOTAL_LEVELS:int = 20
var current_level:int = 1  # note: change to 1 for release
var active_level:GameLevel;

const END_SCREEN = preload("res://levels/end.tscn")
const level_selector_scene = preload("res://levels/menus/level_select_screen.tscn")
const start_scene = preload("res://levels/main_menu.tscn")
var level_selector: Node;
var main: Node;
var end: Node;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#try_start_timer()
	open_main()

func open_main():
	
	
	if level_selector:
		level_selector.queue_free()
	main = start_scene.instantiate()
	add_child(main)
func open_end():
	$Popup.deactivate()
	if level_selector:
		level_selector.queue_free()
		level_selector = null
	if active_level:
		active_level.queue_free()
		active_level = null
	end = END_SCREEN.instantiate()
	add_child(end)
func main_start():
	
	if main:
		main.queue_free()
	if end:
		end.queue_free()
	if LevelCompleted.furthest == 1:
		load_level("res://levels/level" + str(1) + ".tscn")
	else:
		level_selector = level_selector_scene.instantiate()
		add_child(level_selector)
func try_start_timer():
	if has_timer_began:
		return
	var timer = Timer.new()
	timer.wait_time = beattime
	timer.one_shot = false
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	has_timer_began = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		toggle_selector()

func toggle_selector():
	$Popup.deactivate()
	if level_selector:
		open_main()
	elif active_level:
		active_level.queue_free()
		active_level = null
		
		level_selector = level_selector_scene.instantiate()
		add_child(level_selector)
	else:
		level_selector = level_selector_scene.instantiate()
		add_child(level_selector)

func _on_timer_timeout():
	beat_counter += 1
	if beat_counter % 4 == 0:  # music bar
		pass
	if beat_counter % 384 == 0:  # music length
		$BackgroundMusic.play()
	
	if active_level:
		active_level.beat()


func load_level(level_path: String, new_level_id: int = -1):
	if level_selector:
		level_selector.queue_free()
		level_selector = null
	
	var level = load(level_path)
	if not level:
		print("Failed to load level at ", level_path)
		return
	if active_level:
		active_level.queue_free()
	
	var instance = level.instantiate()
	active_level = instance as GameLevel
	active_level.beattime = beattime
	
	if new_level_id >= 0:
		current_level = new_level_id

	var allowed_troops:Dictionary[int, bool] = {
		1: true,
		2: current_level >= 5 or current_level == 0,
		3: current_level >= 10 or current_level == 0,
		4: current_level >= 15 or current_level == 0
	}
	active_level.allowed_troops = allowed_troops
	active_level.win_host_callback = $Popup.activate
	active_level.restart_callback = restart_level
	
	
	add_child(active_level)
	try_start_timer()
	
func restart_level():
	$Popup.deactivate()
	var next_level_path = "res://levels/level" + str(current_level) + ".tscn"
	load_level(next_level_path)
	
func next_level():
	$Popup.deactivate()
	current_level += 1
	if current_level <= TOTAL_LEVELS:
		var next_level_path = "res://levels/level" + str(current_level) + ".tscn"
		load_level(next_level_path)
	else:
		open_end()

func previous_level():
	$Popup.deactivate()
	current_level -= 1
	if current_level > 0:
		var previous_level_path = "res://levels/level" + str(current_level) + ".tscn"
		load_level(previous_level_path)
	else:
		print("Error: Zeroth't level has no previous level.")
		open_end()
		
