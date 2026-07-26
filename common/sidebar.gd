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
	
	$Troops.text = "Slimes left for star: " + str(t)
	$Beats.text = "Beats left for star: " + str(b)
	
	
