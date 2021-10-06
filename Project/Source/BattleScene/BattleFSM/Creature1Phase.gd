extends "res://Source/BattleScene/BattleFSM/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	
	print("Entering creature1phase")
	get_parent().ActivatePlayerTargetingUI(get_parent().activeChar) ;
	#moves, switch, run
	get_parent().DisplayBattleMenu(true, true, true) ;
	

func inputMove():
	change_state("MoveState") ;

func inputRun(): #RUN option
	get_parent().runAttempt += 1 ;
	get_parent().HideTargetUI() ;
	
	if Player.battleTeam[1] != null:
		get_parent().activeChar = Player.battleTeam[1] ;
		change_state("Creature2Phase") ;
	else:
		change_state("EnemyPhase") ;

func inputItem():
	change_state("ItemState") ;

func inputSwitch():
	change_state("SwitchState") ;
