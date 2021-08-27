extends KinematicBody2D

var friction = 400 ;
var acceleration = 150 ;
var max_speed = 50 ;
var velocity = Vector2.ZERO;

func _physics_process(delta):
	var input_vector = Vector2.ZERO ;
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") ;
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") ;
	
	if input_vector != Vector2.ZERO :
		velocity += input_vector.normalized() * (acceleration * delta) ;
		velocity = velocity.clamped(max_speed * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta) ;
	
	move_and_collide(velocity) ;
	
	
