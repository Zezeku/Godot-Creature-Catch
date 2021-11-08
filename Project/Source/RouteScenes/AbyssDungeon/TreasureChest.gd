extends StaticBody2D


export (bool) var isOpen ;
export (String) var item ;

signal isOpened;

func _ready():
	set_process_input(false) ;
	$Chest.frame = isOpen ;

func _input(event):
	if event.is_action_pressed("ui_accept") and !isOpen:
		isOpen = !isOpen ;
		$Chest.frame = isOpen ;
		print("you got an ", item) ;
		emit_signal("isOpened") ;


func _on_Area2D_body_entered(body):
	if body.name == "PlayerController":
		set_process_input(true) ;


func _on_Area2D_body_exited(body):
	if body.name == "PlayerController":
		set_process_input(false) ;
