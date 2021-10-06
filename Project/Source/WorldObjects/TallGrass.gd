extends Area2D


onready var animationPlayer = $AnimationPlayer ;

func setTexture(texture):
	$Sprite.texture = texture ;

func _on_Node2D_body_entered(body):
	if body.name == "PlayerController":
		animationPlayer.play("EnteredTallGrass") ;
		get_parent().IsEncounter() ;
	

func _on_Node2D_body_exited(body):
	if body.name == "PlayerController":
		animationPlayer.play("ExitTallGrass") ;






