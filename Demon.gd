extends KinematicBody2D


var gravity = 20
var velocity = Vector2.ZERO
var jump_force = 500

func _physics_process(delta):
	velocity.y += gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	move_and_slide(velocity, Vector2.UP)
