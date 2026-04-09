class_name Player
extends CharacterBody2D

@export var health : int

@export var mana : int

@export var race : Race

## Holds a reference to the AnimationTree
@export var anim_tree : AnimationTree

## Holds a reference to the StateMachine node
@export var StateMachine : NodeStateController

@export var movable : Movable

@onready var timer := %LifeSpanTimer

var playback : AnimationNodeStateMachinePlayback

func _ready() -> void:
	timer.wait_time = race.lifespan * 60 * 60
	timer.start()
	health = race.base_health
	mana = race.base_mana
	playback = anim_tree["parameters/playback"]

func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_life_span_timer_timeout() -> void:
	queue_free()
