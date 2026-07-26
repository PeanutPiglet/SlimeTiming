extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	
	var level = get_parent().scene_file_path.to_int()
	if level >= 5:
		$defense.visible = true
	if level >= 10:
		$cross.visible = true
	if level >= 15: 
		$boost.visible = true
	
	
func update(maxt,troop, maxb, beats):
	var t = maxt-troop
	var b = maxb-beats
	if t < 0: 
		t = 0
		$star3.visible = false
	if b < 0: 
		b = 0
		$star2.visible = false
	
	$Troops.text = "%d" % t
	$Beats.text = "%d" % b


func _on_burger_pressed() -> void:
	get_tree().current_scene.toggle_selector()

func _on_restart_button_pressed() -> void:
	get_tree().current_scene.restart_level()
