extends "res://Source/BattleScene/BattleFSM/State.gd"



func enter(fsm:StateMachine):
	_fsm = fsm ;
	print("Entering move phase for creature", get_parent().activeChar.name) ;
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
	get_parent().HideMoves() ;
	Player.moveUse[Player.battleTeam.find(get_parent().activeChar)] = null ;
	_fsm.previous_state() ;

func inputMoveSelect(moveSelection):
	if get_parent().activeChar.moveList[moveSelection].pre_execute(get_parent().activeChar):
		
		Player.moveUse[Player.battleTeam.find(get_parent().activeChar)] = moveSelection ;
		decide_next_state() ;
	else:
		BattleLog.updateBattleLog("Not enough resource to use the ability") ;
		get_parent().DisplayMoves() ;
