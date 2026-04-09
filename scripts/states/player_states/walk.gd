extends PlayerState

func _on_process(_delta : float) -> void:
	if movable.get_input_vector() == Vector2.ZERO:
		transition.emit(&"idle")
	if movable.swing_pressed():
		transition.emit(&"swing")

func _on_physics_process(_delta : float) -> void:
	input_vector = movable.get_input_vector()
	parent.velocity = input_vector * movable.speed
	
	update_anim_parameters(input_vector)

func _on_next_transitions() -> void:
	select_anim("walk")

func _on_enter() -> void:
	pass

func _on_exit() -> void:
	pass
