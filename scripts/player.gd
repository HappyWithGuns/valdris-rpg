class_name Player
extends CharacterBody2D

@export_group("Stats")
@export var race : Race
@export var stamina : int

@export_group("References")
## Holds a reference to the AnimationTree
@export var anim_tree : AnimationTree
## Holds a reference to the StateMachine node
@export var StateMachine : NodeStateController
@export var movable : Movable
@export var stamina_bar : ProgressBar
## The Area2D used for enemy detection
@export var detection_area : Area2D

var playback : AnimationNodeStateMachinePlayback

var locked_on := false

var current_stamina
var current_health
var current_mana

var burnt_out : bool = false

func _ready() -> void:
	current_stamina = stamina
	current_health = race.base_health
	current_mana = race.base_mana
	
	stamina_bar.max_value = stamina
	stamina_bar.value = current_stamina
	
	anim_tree.active = true
	
	if anim_tree:
		playback = anim_tree["parameters/playback"]

func _process(delta: float) -> void:
	_handle_stamina()

func _physics_process(_delta: float) -> void:
	move_and_slide()


func _handle_stamina():
	if StateMachine.current_node_state_name != "sprint":
		if burnt_out:
			current_stamina += 0.5
		else:
			current_stamina += 1
	
	if current_stamina <= 0:
		burnt_out = true
	
	if burnt_out and current_stamina == 100:
		burnt_out = false
	
	current_stamina = clamp(current_stamina, stamina_bar.min_value, stamina_bar.max_value)
	
	stamina_bar.value = current_stamina

#func attack_enemy():
	#if target_enemy:
		## 1. Look for EnemyTarget (Handles UI/Damage Numbers)
		#var target_node = target_enemy.get_node_or_null("EnemyTarget")
		#
		#if target_node and target_node.has_method("handle_hit"):
			#target_node.handle_hit(20.0)
			#print("Hit triggered on: ", target_enemy.name)
		#else:
			## 2. Fallback: Search specifically for the script component
			## We use 'true, false' in find_child to search recursively but stay safe
			#var enemy_comp = target_enemy.find_child("EnemyComponent", true, false)
			#
			## Check if it exists AND has the function
			#if enemy_comp and enemy_comp.has_method("take_damage"):
				#enemy_comp.take_damage(20.0)
				#print("No EnemyTarget found, damaged Component directly.")
			#else:
				#push_error("Error: Found node 'EnemyComponent' but it's missing the take_damage script!")

#func look_at_target():
	## Keep the tree off while manual-steering animations
	#var dir = (target_enemy.global_position - global_position).normalized()
	#StateMachine.current_node_state.update_anim_parameters(dir)

#func update_anim_parameters(input_vector : Vector2) -> void:
	#if input_vector == Vector2.ZERO:
		#return
	#
	#var parameter_vector = Vector2(input_vector.x, -input_vector.y)
	#
	#anim_tree["parameters/idle/blend_position"] = parameter_vector
	#anim_tree["parameters/walk/blend_position"] = parameter_vector
	#anim_tree["parameters/swing/blend_position"] = parameter_vector

#func _on_detection_area_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Enemy"):
		## Lock onto the first enemy that walks in
		#if target_enemy == null:
			#target_enemy = body
			#print("Enemy detected: ", body.name)

#func find_target():
	#var bodies = detection_area.get_overlapping_bodies()
	#target_enemy = null
	#
	#for body in bodies:
		#if body.is_in_group("Enemy"):
			#target_enemy = body
			#break # Just grab the first available one

#func _on_detection_area_body_exited(body: Node2D) -> void:
	#if body == target_enemy:
		## If our current target leaves, stop looking at them
		#target_enemy = null
		#print("Target lost.")
		#
		## Optional: Try to find another enemy still in the area
		#find_target()
