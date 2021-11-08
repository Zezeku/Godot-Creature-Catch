extends KinematicBody2D

var friction = 500 ;
var acceleration = 500 ;
var max_speed = 50 ;
var velocity = Vector2.ZERO;
var isActive = true ; #dont think i need anymore, now that i know i can turn off process with set_physicsProcess


onready var animationPlayer = $AnimationPlayer ;
onready var animationTree = $AnimationTree ;
onready var animationState = animationTree.get("parameters/playback") ;

#func _ready():
#	set_physics_process(false) ;

func _physics_process(delta):
	if isActive:
		var input_vector = Vector2.ZERO ;
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") ;
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") ;
		input_vector = input_vector.normalized();
			
		if input_vector != Vector2.ZERO:
			if !animationTree.active: #we check for this because in some cases like cutscenes, we override the animation tree
				animationTree.active = true ; #not doing so causes the sprite to change to default animation tree frame when we dont want it to
			animationTree.set("parameters/Idle/blend_position",input_vector) ;
			animationTree.set("parameters/Walk/blend_position",input_vector) ;
			animationState.travel("Walk") ;
			velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta) ;
			
		else:
			animationState.travel("Idle") ;
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta) ;
		
# warning-ignore:return_value_discarded
		move_and_slide(velocity) ;
	

#func _input(event):
#	if event.is_action_pressed("Sprint"):
#		max_speed = 50 ;
#	if event.is_action_released("Sprint"):
#		max_speed = 50 ;

func setSpeed(speed):
	
	
	
	max_speed = speed ;

func move_to(pos, time):
	
	$Tween.interpolate_property(self, "position", position, pos, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT) ;
	$Tween.start() ;

func play_anim(animation):
	$AnimationPlayer.play(animation) ;
