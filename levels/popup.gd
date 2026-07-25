extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func activate() -> void:
	print(get_viewport().get_size())
	self.visible = true
