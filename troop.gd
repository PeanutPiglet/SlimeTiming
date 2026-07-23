extends Node2D

var moveable = false
# Called when the node enters the scene tree for the first time.
func _ready():
	#slight delay before can move
	await get_tree().create_timer(0.25).timeout
	moveable = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
		

func move():
	if moveable:
		position.x += 64
