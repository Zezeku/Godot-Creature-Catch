extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Node2D_body_entered(_body):
	$Sprite.visible = false;
	$AnimatedSprite.frame = 0;
	$AnimatedSprite.play("default");
	$AnimatedSprite.visible = true ;
	


func _on_AnimatedSprite_animation_finished():
	$Sprite.visible = true ;
	$AnimatedSprite.visible = false ;
