class_name TowerTeleporter extends Tower

@export var destination: TowerTeleporter
@export var tower: Tower

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func activate():
	print("TELEPORTING")
	if tower:
		$AnimatedSprite2D.play()
		$Timer.start()
		if not destination.tower:
			destination.get_node("AnimatedSprite2D").play()


func _on_timer_timeout() -> void:
	if not destination or not tower:
		return
	if destination.tower:
		return
		
	tower.global_position = destination.global_position
	destination.tower = tower
	tower = null
