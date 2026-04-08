extends PlayerState

func _on_process(_delta : float) -> void:
	if movable.get_input_vector() != Vector2.ZERO:
		transition.emit(&"walk")

func _on_physics_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	pass

func _on_enter() -> void:
	select_anim("idle")
	parent.velocity = Vector2.ZERO

func _on_exit() -> void:
	pass
