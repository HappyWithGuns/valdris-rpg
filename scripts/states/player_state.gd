class_name PlayerState
extends NodeState

## Holds a reference to the player
@export var parent : Player

## Holds a reference to the player
@export var movable : Movable

## Contains the 2D direction in which the player is moving
var input_vector : Vector2

## changes the paremeters for the animation state machine for the 8 way movement
func update_anim_parameters(input_vector : Vector2) -> void:
	if input_vector == Vector2.ZERO:
		return
	
	var parameter_vector = Vector2(input_vector.x, -input_vector.y)
	
	parent.anim_tree["parameters/idle/blend_position"] = parameter_vector
	parent.anim_tree["parameters/walk/blend_position"] = parameter_vector

## Allows the selection of a specific animation group of the same input from the AnimationTree
func select_anim(anim_name : String) -> void:
	if parent.playback == null:
		parent.playback = parent.anim_tree["parameters/playback"]
	parent.playback.travel(anim_name)
