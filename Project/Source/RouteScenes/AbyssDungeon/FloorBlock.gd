extends Area2D


var isStepped = false ;
signal isStepped(block, my_position)




func _on_FloorBlock_body_entered(body):
	if body.name == "PlayerController" and !isStepped:
		emit_signal("isStepped", self, position) ;

func flip():
	isStepped = true ;
	$Block.frame = 1 ;
