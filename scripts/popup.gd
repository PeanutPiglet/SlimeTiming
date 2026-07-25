extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_stars()
	self.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate() -> void:
	self.position = _get_viewport_center();
	var curlevel = get_tree().current_scene.current_level;
	$next.visible = true
	if curlevel > 1:
		$previous.visible = true
	else:
		$previous.visible = false
	$levelN.text = "LEVEL %d" % curlevel;
	
	# stars
	var stars_punchcard = LevelCompleted["stars"][curlevel];
	var stars : int = 0;
	for star in stars_punchcard:
		if star:
			stars += 1
	print(stars_punchcard, stars)
	hide_stars()
	
	# set visible
	self.visible = true
	play_stars(stars)

func play_stars(stars) -> void:
	if stars > 1:
		$star1.visible = true
		$star1.play()
	if stars > 0:  # middle star
		$star2.visible = true
		$star2.play()
	if stars > 2:
		$star3.visible = true
		$star3.play()

func hide_stars() -> void:
	$star1.visible = false
	$star2.visible = false
	$star3.visible = false

func deactivate() -> void:
	hide_stars()
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
	return Vector2(size[0] / 2, size[1] / 2)
