class_name Player
extends CharacterBody2D

## Holds a reference to the AnimationTree
@export var anim_tree : AnimationTree

## Holds a reference to the StateMachine node
@export var StateMachine : NodeStateController

var playback : AnimationNodeStateMachinePlayback

func _ready() -> void:
	playback = anim_tree["parameters/playback"]

func _physics_process(delta: float) -> void:
	move_and_slide()
