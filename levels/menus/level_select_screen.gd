extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range (1,21):
		var node = str(i)
		get_node(node).set_visible(false)
		
	for i in range (1, LevelCompleted.furthest + 1):
		var node = str(i)
		if(i!=21):
			
			get_node(node).set_visible(true)
			get_node(node).text = node
			get_node(node).connect("pressed", _on_start_pressed.bind(get_node(node).name))
			var button = get_node(node) 
			for j in range(0,3):
				if LevelCompleted.stars[i][j-1]:
					var star = Sprite2D.new()
					star.texture = load("res://assets/smallstar.png")
					star.position = Vector2(32+ 32*j, 64)
					button.add_child(star)

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main.tscn")
func _on_start_pressed(name):
	var file = ("res://levels/level"+ str(name)+ ".tscn")
	get_tree().current_scene.load_level(file, int(name))
