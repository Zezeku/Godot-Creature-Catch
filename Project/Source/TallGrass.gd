extends Area2D


onready var animationPlayer = $AnimationPlayer ;


func _ready():
	pass;

func _on_Node2D_body_entered(_body):
	animationPlayer.play("EnteredTallGrass") ;
	get_parent().IsEncounter() ;
	

func _on_Node2D_body_exited(_body):
	animationPlayer.play("ExitTallGrass") ;






