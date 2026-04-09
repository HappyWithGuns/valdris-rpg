class_name EnemyComponent
extends Node2D

signal health_changed(current_health)
signal died

@export var max_health: float = 100.0
@onready var current_health: float = max_health

func _ready() -> void:
	if not get_parent().is_in_group("Enemy"):
		get_parent().add_to_group("Enemy")

func take_damage(amount: float) -> void:
	if current_health <= 0: return # Already dead
	
	current_health -= amount
	health_changed.emit(current_health)
	print("Enemy hit! Health remaining: ", current_health)
	
	if current_health <= 0:
		die()

func die() -> void:
	died.emit()
	print("Enemy defeated.")
	get_parent().queue_free() # Actually removes the enemy
