class_name Player
extends CharacterBody2D

@export_group("Stats")
@export var health : int
@export var mana : int

@export_group("References")
## Holds a reference to the AnimationTree
@export var anim_tree : AnimationTree
## Holds a reference to the StateMachine node
@export var StateMachine : NodeStateController
@export var movable : Movable
## The Area2D used for enemy detection
@export var detection_area : Area2D

var playback : AnimationNodeStateMachinePlayback
var target_enemy : Node2D = null

func _ready() -> void:
	if anim_tree:
		playback = anim_tree["parameters/playback"]
	
	# Fail-safe check
	if detection_area == null:
		push_warning("Detection Area is missing on " + name + "! Make sure to assign it in the Inspector.")

func _physics_process(_delta: float) -> void:
	if target_enemy:
		look_at_target()
		
		# Check for attack input while a target is locked
		if Input.is_action_just_pressed("swing"): # Ensure "attack" is set in Input Map
			attack_enemy()
	else:
		# Ensure tree is active if no target
		anim_tree.active = true
		
	move_and_slide()

func apply_force(force : float, acceleratio_time : float, length_of_tween : float) -> void:
	var input_vec : Vector2 = movable.get_input_vector() if movable else Vector2.ZERO
	var impluse : Vector2 = Vector2(force * acceleratio_time, force * acceleratio_time) * input_vec
	create_tween().set_ease(Tween.EASE_IN).tween_property(self, "velocity", impluse, length_of_tween)

func attack_enemy():
	if target_enemy:
		# 1. Look for EnemyTarget (Handles UI/Damage Numbers)
		var target_node = target_enemy.get_node_or_null("EnemyTarget")
		
		if target_node and target_node.has_method("handle_hit"):
			target_node.handle_hit(20.0)
			print("Hit triggered on: ", target_enemy.name)
		else:
			# 2. Fallback: Search specifically for the script component
			# We use 'true, false' in find_child to search recursively but stay safe
			var enemy_comp = target_enemy.find_child("EnemyComponent", true, false)
			
			# Check if it exists AND has the function
			if enemy_comp and enemy_comp.has_method("take_damage"):
				enemy_comp.take_damage(20.0)
				print("No EnemyTarget found, damaged Component directly.")
			else:
				push_error("Error: Found node 'EnemyComponent' but it's missing the take_damage script!")

func look_at_target():
	# Keep the tree off while manual-steering animations
	anim_tree.active = false 
	
	var dir = (target_enemy.global_position - global_position).normalized()
	update_sprite_direction(dir)

func update_sprite_direction(direction: Vector2):
	# Adjust these paths to match your actual AnimationTree BlendSpace names
	anim_tree.set("parameters/Idle/blend_position", direction)
	anim_tree.set("parameters/Walk/blend_position", direction)

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		# Lock onto the first enemy that walks in
		if target_enemy == null:
			target_enemy = body
			print("Enemy detected: ", body.name)

func find_target():
	var bodies = detection_area.get_overlapping_bodies()
	target_enemy = null
	
	for body in bodies:
		if body.is_in_group("Enemy"):
			target_enemy = body
			break # Just grab the first available one

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == target_enemy:
		# If our current target leaves, stop looking at them
		target_enemy = null
		anim_tree.active = true # Restore normal movement animations
		print("Target lost.")
		
		# Optional: Try to find another enemy still in the area
		find_target()
