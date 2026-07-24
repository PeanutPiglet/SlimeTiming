extends Node2D

@export var speed = 1000
@export var duration = 3
@export var damage = 1

var already_hit = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = duration
	timer.one_shot = true
	timer.autostart = true
	timer.timeout.connect(queue_free)
	add_child(timer)

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
	

func _physics_process(delta: float) -> void:
	var direction = -transform.y
	position += direction * speed * delta


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("troop_damageable"):
		print(area)
		if area in already_hit:
			return
		already_hit.append(area)
		var troop = area.get_parent() as Troop
		if troop:
			troop.take_damage(damage)
		
