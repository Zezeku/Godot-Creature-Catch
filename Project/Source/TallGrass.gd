extends Area2D

var body_exit;
var body_enter;

func on_ready():
	body_exit = false;
	body_enter = false;

func _on_Node2D_body_entered(_body):
	body_enter = true
	$Sprite.visible = false;
	$AnimatedSprite.frame = 0;
	$AnimatedSprite.play("HalfGrow");
	$AnimatedSprite.visible = true ;
	
	

func _on_Node2D_body_exited(body):
	body_exit = true
	$Sprite2.visible = false;
	$AnimatedSprite.frame = 1 ;
	$AnimatedSprite.play("FullGrow") ;
	$AnimatedSprite.visible = true ;
	

func _on_AnimatedSprite_animation_finished():
	
	if body_enter:
		$Sprite2.visible = true ;
	else:
		$Sprite.visible = true ;
	
	$AnimatedSprite.visible = false ;
	body_exit = false ;
	body_enter = false ;



