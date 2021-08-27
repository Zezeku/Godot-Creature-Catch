extends Area2D


onready var animationPlayer = $AnimationPlayer ;


func _on_Node2D_body_entered(body):
	animationPlayer.play("EnteredTallGrass") ;

func _on_Node2D_body_exited(body):
	animationPlayer.play("ExitTallGrass") ;






