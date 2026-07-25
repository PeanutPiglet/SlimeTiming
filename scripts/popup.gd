extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate() -> void:
	var vsize = get_viewport().get_size()
	self.position.x = vsize[0]/2
	self.position.y = vsize[1]/2
	var curlevel = get_tree().current_scene.current_level;
	$levelN.text = "LEVEL %d" % curlevel;
	self.visible = true

func deactivate() -> void:
	self.visible = false

func _on_restart_pressed() -> void:
	get_tree().current_scene.restart_level()

func _on_next_pressed() -> void:
	get_tree().current_scene.next_level()

func _on_previous_pressed() -> void:
	pass # Replace with function body.
