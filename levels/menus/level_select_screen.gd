extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range (1,21):
		var node = str(i)
		get_node(node).set_visible(false)
		
	for i in range (1, LevelCompleted.furthest+1):
		var node = str(i)
		if(i!=21):
			get_node(node).set_visible(true)
			get_node(node).text = node
			get_node(node).connect("pressed", _on_start_pressed.bind(get_node(node).name))
		

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main.tscn")
func _physics_process(_delta):
	if(Input.is_action_just_pressed("escape")):
		get_tree().change_scene_to_file("res://scenes/menus/main.tscn")
func _on_start_pressed(name):
	var file = ("res://levels/level"+ str(name)+ ".tscn")
	get_tree().current_scene.load_level(file)
