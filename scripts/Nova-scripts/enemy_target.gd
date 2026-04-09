extends StaticBody2D

func _ready():
	start_bobbing()

func start_bobbing():
	# Godot 4 uses create_tween() instead of the Tween node
	var tween = create_tween().set_loops() # set_loops() makes it infinite
	var start_pos = position
	var end_pos = position + Vector2(0, -15)
	
	# Move up
	tween.tween_property(self, "position", end_pos, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	# Move down
	tween.tween_property(self, "position", start_pos, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
