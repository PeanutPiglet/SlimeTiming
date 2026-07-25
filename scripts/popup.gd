extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate() -> void:
	self.position = _get_viewport_center();
	var curlevel = get_tree().current_scene.current_level;
	if curlevel < get_tree().current_scene.TOTAL_LEVELS - 1:
		$next.visible = true
	else:
		$next.visible = false
	if curlevel > 0:
		$previous.visible = true
	else:
		$previous.visible = false
	$levelN.text = "LEVEL %d" % curlevel;
	
	# stars
	$star1.visible = false
	$star2.visible = false
	$star3.visible = false
	
	self.visible = true

func deactivate() -> void:
	self.visible = false

func _on_restart_pressed() -> void:
	self.deactivate()
	get_tree().current_scene.restart_level()

func _on_next_pressed() -> void:
	self.deactivate()
	get_tree().current_scene.next_level()

func _on_previous_pressed() -> void:
	self.deactivate()
	get_tree().current_scene.previous_level()

func _get_viewport_center() -> Vector2:
	#var scale : Vector2 = transform.get_scale()
	var size: Vector2 = get_viewport_rect().size;
	print(size, scale)
	return Vector2(size[0] / 2, size[1] / 2)
