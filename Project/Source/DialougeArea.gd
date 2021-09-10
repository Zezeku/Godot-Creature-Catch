extends Area2D

var active = false ;

func _ready():
	pass # Replace with function body.



func _input(event):
	if event.is_action_pressed("ui_accept") and active:
		#pause the tree and let this process
		#dont let player do action while this is happening
		#figure out player loc and frame to determine if looking at npc
		# x> & y<, x> and y>, etc.. and frame is 0 thru 4, ... etc.
		if get_node("../Panel").visible == false :
			get_node("../Panel").visible = true ;
		else:
			get_node("../Panel").visible = false ;

func _on_DialougeArea_body_entered(body):
	if body.name == "PlayerController":
		active = true ;


func _on_DialougeArea_body_exited(body):
	if body.name == "PlayerController":
		active = false ;
		get_node("../Panel").visible = false ;
