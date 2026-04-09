class_name Player
extends CharacterBody2D

@export var health : int

@export var mana : int

## Holds a reference to the AnimationTree
@export var anim_tree : AnimationTree

## Holds a reference to the StateMachine node
@export var StateMachine : NodeStateController

@export var movable : Movable

var playback : AnimationNodeStateMachinePlayback

func _ready() -> void:
	playback = anim_tree["parameters/playback"]

func _physics_process(delta: float) -> void:
	move_and_slide()

func apply_force(force : float, acceleratio_time : float, length_of_tween : float) -> void:
	var impluse := Vector2(force * acceleratio_time, force * acceleratio_time) * movable.get_input_vector()
	create_tween().set_ease(Tween.EASE_IN).tween_property(self, "velocity", impluse, length_of_tween)
