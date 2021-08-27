extends KinematicBody2D

var friction = 500 ;
var acceleration = 500 ;
var max_speed = 60 ;
var velocity = Vector2.ZERO;

func _physics_process(delta):
	var input_vector = Vector2.ZERO ;
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") ;
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") ;
	input_vector = input_vector.normalized();
	
	if input_vector != Vector2.ZERO :
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta) ;
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta) ;
	
	move_and_collide(velocity * delta) ;
	
	
