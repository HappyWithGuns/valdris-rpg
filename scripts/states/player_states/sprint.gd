extends PlayerState

func _on_process(_delta : float) -> void:
	parent.current_stamina -= 0.5
	
	if parent.burnt_out:
		transition.emit(&"walk")
	
	if Input.is_action_just_pressed("swing"):
		transition.emit(&"swing")
	if Input.is_action_just_released("sprint"):
		if movable.get_input_vector() != Vector2.ZERO:
			transition.emit(&"walk")
		else:
			transition.emit(&"idle")

func _on_physics_process(_delta : float) -> void:
	input_vector = movable.get_input_vector()
	parent.velocity = input_vector * movable.sprint_speed
	
	if !parent.locked_on:
		update_anim_parameters(input_vector)

func _on_next_transitions() -> void:
	pass

func _on_enter() -> void:
	select_anim("sprint")

func _on_exit() -> void:
	pass
