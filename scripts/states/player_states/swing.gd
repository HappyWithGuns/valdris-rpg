extends PlayerState

func _on_process(_delta : float) -> void:
	await parent.anim_tree.animation_finished
	
	update_anim_parameters(input_vector)
	
	if movable.get_input_vector() != Vector2.ZERO:
		transition.emit(&"walk")
	else:
		transition.emit(&"idle")

func _on_physics_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	pass

func _on_enter() -> void:
	parent.velocity = Vector2.ZERO
	parent.apply_force(300, 0.5, 0.5)
	select_anim("swing")

func _on_exit() -> void:
	pass
