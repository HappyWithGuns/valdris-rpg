class_name Movable
extends Node

## the normal walkspeed of the object
@export var speed : float

## return players input vector where (left = -x, right = +x, up = -y, down = +y)
func get_input_vector() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")
