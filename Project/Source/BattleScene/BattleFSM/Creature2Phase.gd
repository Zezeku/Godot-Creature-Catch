extends "res://Source/BattleScene/BattleFSM/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	
	
	get_parent().activeChar.get_child(0).frame = 3 ;
	get_parent().DisplayBattleMenu(true, false, true) ;
	

func isMon2():
	return Player.battleTeam[1] ;

func inputMove():
	change_state("MoveState") ;

func inputRun():
	get_parent().runAttempt += 1 ;
	get_parent().activeChar.get_child(0).frame = 2 ;
	change_state("EnemyPhase") ;

func inputItem():
	change_state("ItemState") ;

func inputCancel():
	if Player.battleTeam[0]:
		get_parent().activeChar.get_child(0).frame = 2 ;
		get_parent().activeChar = Player.battleTeam[0] ;
		Player.targetUse[0] = null ;
		Player.moveUse[0] = null ;
		Player.itemUse[0] = null ;
		get_parent().runAttempt = 0 ;
		change_state("Creature1Phase") ;
	
