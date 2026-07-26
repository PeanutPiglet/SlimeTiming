extends Node2D

func activate():
	self.position = _get_viewport_center()
	self.visible = true
	$AnimationPlayer.play("rotate")

func _get_viewport_center() -> Vector2:
	#var scale : Vector2 = transform.get_scale()
	var size: Vector2 = get_viewport_rect().size;
	return Vector2(size[0] / 2, size[1] / 2)


#func _on_animated_sprite_2d_animation_finished() -> void:
	#self.visible = false
	#pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	self.visible = false
	pass # Replace with function body.
