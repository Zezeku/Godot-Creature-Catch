extends PopupPanel

onready var button1 = "VBox/HBox/VBox2/Move1";
onready var button2 = "VBox/HBox/VBox2/Move2";
onready var button3 = "VBox/HBox/VBox3/Move3";
onready var button4 = "VBox/HBox/VBox3/Move4";

var moveSelection 


signal moveSelect(move) ;

func DisplayMoves(moveList):
	var buttons = [button1, button2, button3, button4] ;
	
	for m in moveList.size():
		get_node(buttons[m]).set_text(moveList[m].skillName) ;
		get_node(buttons[m]).hint_tooltip = moveList[m].tool_tip ;
		get_node(buttons[m]).disabled = false ;
		
	visible = true ;

func resetButtons():
	var buttons = [button1, button2, button3, button4] ;
	
	for m in buttons.size():
		get_node(buttons[m]).disabled = true ;




func _on_Move1_pressed():
	moveSelection = 0 ;
	resetButtons() ;
	visible = false ;
	emit_signal("moveSelect", moveSelection) ;
	


func _on_Move2_pressed():
	moveSelection = 1 ;
	resetButtons() ;
	visible = false ;
	get_node("../BattleMenu").visible = false ;
	emit_signal("moveSelect", moveSelection) ;


func _on_Move3_pressed():
	moveSelection = 2 ;
	resetButtons() ;
	visible = false ;
	get_node("../BattleMenu").visible = false ;
	emit_signal("moveSelect", moveSelection) ;


func _on_Move4_pressed():
	moveSelection = 3 ;
	resetButtons() ;
	visible = false ;
	get_node("../BattleMenu").visible = false ;
	emit_signal("moveSelect", moveSelection) ;
