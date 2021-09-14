extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm ;
	
	print("\nenter_", get_parent().activeChar.name, "_moveState");
	print(get_parent().activeChar.moveList()) ;
	get_parent().displayMoves() ;
	

func decide_next_state():
	change_state("TargetPhase") ;


#func inputOne():
#	Player.moveUse[get_parent().activeChar.get_index()] = 0 ;
#	decide_next_state() ;
#
#func inputTwo():
#	Player.moveUse[get_parent().activeChar.get_index()] = 1 ;
#	decide_next_state() ;
#
#func inputThree():
#	Player.moveUse[get_parent().activeChar.get_index()] = 2 ;
#	decide_next_state() ;


func _on_MoveMenu_moveSelect(move):
	Player.moveUse[get_parent().activeChar.get_index()] = move ;
	print(Player.moveUse[get_parent().activeChar.get_index()])
	decide_next_state() ;
