extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate():	#timer 
	var timer = Timer.new()
	timer.wait_time = 2
	timer.one_shot = true
	timer.autostart = false
	timer.timeout.connect(deactivate)
	add_child(timer)
	$AnimatedSprite2D.play("vertical")
	
func deactivate():
	$AnimatedSprite2D.pause()
