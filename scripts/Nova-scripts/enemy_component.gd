class_name EnemyComponent
extends Node2D

signal health_changed(current_health)
signal died

@export var max_health: float = 100.0
@onready var current_health: float = max_health
@onready var Damagenumber : PackedScene = preload("res://scenes/Nova-scenes/DamageNumber.tscn")

func _ready() -> void:
	if not get_parent().is_in_group("Enemy"):
		get_parent().add_to_group("Enemy")

func take_damage(amount: float) -> void:
	if current_health <= 0: return # Already dead
	
	current_health -= amount
	
	# 1. Instantiate the label
	var dmg_label = Damagenumber.instantiate()
	
	# 2. Add it to the scene (Adding to the owner or root keeps it from disappearing if the enemy dies)
	get_tree().current_scene.add_child(dmg_label)
	
	# 3. Position it at the enemy's location
	dmg_label.global_position = global_position
	
	# 4. Set the text
	dmg_label.set_values(amount)
	
	health_changed.emit(current_health)
	print("Enemy hit! Health remaining: ", current_health)
	
	if current_health <= 0:
		die()

func die() -> void:
	died.emit()
	print("Enemy defeated.")
	get_parent().queue_free() # Actually removes the enemy
