extends Node

@export var beattime:float = 0.75

const TOTAL_LEVELS:int = 20
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout():
	if active_level:
		active_level.beat()


func win():
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level = current_scene_file.to_int() + 1
	if next_level < TOTAL_LEVELS:
		var next_level_path = "res://levels/level" + str(next_level) + ".tscn"
		get_tree().change_scene_to_file(next_level_path)
	else:
		get_tree().change_scene_to_file(END_SCREEN)
