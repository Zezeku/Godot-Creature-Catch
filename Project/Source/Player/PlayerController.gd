extends KinematicBody2D

var friction = 500 ;
var acceleration = 500 ;
var max_speed = 60 ;
var velocity = Vector2.ZERO;
var isActive = true ;


onready var animationPlayer = $AnimationPlayer ;
onready var animationTree = $AnimationTree ;
onready var animationState = animationTree.get("parameters/playback") ;


func _physics_process(delta):
	if isActive:
		var input_vector = Vector2.ZERO ;
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") ;
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") ;
		input_vector = input_vector.normalized();
			
		if input_vector != Vector2.ZERO :
			animationTree.set("parameters/Idle/blend_position",input_vector) ;
			animationTree.set("parameters/Walk/blend_position",input_vector) ;
			animationState.travel("Walk") ;
			velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta) ;
			
		else:
			animationState.travel("Idle") ;
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta) ;
		
		move_and_slide(velocity) ;
	

func _input(event):
	if event.is_action_pressed("Sprint"):
		max_speed = 100 ;
	if event.is_action_released("Sprint"):
		max_speed = 60 ;

