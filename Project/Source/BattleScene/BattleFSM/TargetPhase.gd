extends "res://Source/BattleScene/BattleFSM/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm ;
	
	get_parent().DisplayTargetUI() ;



func decide_next_state():
	
	get_parent().activeChar.get_child(0).frame = 2 ;
	
	if get_parent().activeChar == Player.battleTeam[0]:
		
		if Player.battleTeam[1]:
			get_parent().activeChar = Player.battleTeam[1] ;
			change_state("Creature2Phase") ;
		else:
			change_state("EnemyPhase") ;
	else:
		change_state("EnemyPhase") ;




func inputTargetSelect(targetSelect):
	Player.targetUse[get_parent().activeChar.get_index()] = targetSelect ;
	decide_next_state() ;

func inputCancel():
	Player.targetUse[get_parent().activeChar.get_index()] = null ;
	_fsm.previous_state() ;
