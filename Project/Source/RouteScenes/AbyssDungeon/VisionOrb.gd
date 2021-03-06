extends StaticBody2D


export (bool) var isOn ;
signal isOn(orb) ;

func _ready():
	set_process_input(false) ;
	$OrbColor.frame = isOn ;

func _input(event):
	if event.is_action_pressed("ui_accept"):
		emit_signal("isOn", self) ;

func _on_Area2D_body_entered(body):
	
	if body.name == "PlayerController":
		set_process_input(true) ;
		


func _on_Area2D_body_exited(body):
	if body.name == "PlayerController":
		set_process_input(false) ;
		

func flip():
	isOn = !isOn ;
	$OrbColor.frame = isOn ;
