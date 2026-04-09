extends Label
class_name DamageNumber

func _ready():
	# Animation for the floating text
	var tween = create_tween()
	# Float up and fade out
	# Use TRANS_SINE or TRANS_QUART for a smooth "out" feel
	tween.tween_property(self, "position:y", position.y - 50, 0.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 0.8)
	# Delete when finished
	tween.finished.connect(queue_free)

func set_values(amount: float):
	text = str(amount)
