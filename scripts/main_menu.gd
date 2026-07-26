extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func play_game():
	get_parent().main_start()
	


func _on_button_button_up():
	play_game()
	
	
func play_intro():
	$IntroMusic.play()
	
