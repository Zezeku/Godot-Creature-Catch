extends Area2D


signal LavaCliffsOn ;
signal LavaCliffsOff ;

func _on_Bridge2D_body_entered(body):
	if body.name == "PlayerController":
		emit_signal("LavaCliffsOff") ;


func _on_Bridge2D_body_exited(body):
	if body.name == "PlayerController":
		emit_signal("LavaCliffsOn") ;
