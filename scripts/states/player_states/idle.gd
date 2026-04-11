extends PlayerState

func _on_process(_delta : float) -> void:
	if movable.get_input_vector() != Vector2.ZERO:
		if Input.is_action_pressed("sprint") and !parent.burnt_out:
			transition.emit(&"sprint")
		transition.emit(&"walk")
	if Input.is_action_just_pressed("swing"):
		transition.emit(&"swing")

func _on_physics_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	pass

func _on_enter() -> void:
	select_anim("idle")
	parent.velocity = Vector2.ZERO

func _on_exit() -> void:
	pass
