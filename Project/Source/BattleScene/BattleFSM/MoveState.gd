extends "res://Source/BattleScene/BattleFSM/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm ;
	
	get_parent().DisplayMoves() ;
	

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

func inputCancel():
	get_parent().hideDisplayMoves() ;
	_fsm.previous_state() ;

func inputMoveSelect(moveSelection):
	#should generalize like items
	#we create move button, with script to store data
	Player.moveUse[get_parent().activeChar.get_index()] = moveSelection ;
	decide_next_state() ;
