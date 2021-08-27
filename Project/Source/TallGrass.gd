extends Area2D


onready var animationPlayer = $AnimationPlayer ;


func _on_Node2D_body_entered(_body):
	animationPlayer.play("EnteredTallGrass") ;

func _on_Node2D_body_exited(_body):
	animationPlayer.play("ExitTallGrass") ;






