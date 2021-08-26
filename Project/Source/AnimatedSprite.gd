extends KinematicBody2D

var speed = 16 ;
var move_dir = Vector2();

func get_input():
	print(position)
	move_dir = Vector2();
	
	if Input.is_action_just_pressed("ui_right"):
		move_dir.x += 0.25 ;
	if Input.is_action_just_pressed("ui_left"):
		move_dir.x -= 0.25 ;
	if Input.is_action_just_pressed("ui_up"):
		move_dir.y -= 0.25 ;
	if Input.is_action_just_pressed("ui_down"):
		move_dir.y += 0.25 ;
		
	
	

func _physics_process(_delta):
	get_input()
	translate(move_dir*speed) ;
	
