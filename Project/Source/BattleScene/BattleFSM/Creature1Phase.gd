extends "res://Source/BattleScene/BattleFSM/State.gd"



func enter(fsm:StateMachine):
	_fsm = fsm
	
	get_parent().activeChar.get_child(0).frame = 3 ;
	#moves, switch, run
	get_parent().DisplayBattleMenu(true, false, true) ;
	


#this one is ok, specific to battle scene
func isMon1():
	return Player.battleTeam[0] ;
	
func isMon2():
	return Player.battleTeam[1] ;

func inputMove():
	change_state("MoveState") ;

func inputRun(): #RUN option
	get_parent().runAttempt += 1 ;
	get_parent().activeChar.get_child(0).frame = 2 ;
	
	if isMon2():
		get_parent().activeChar = Player.battleTeam[1] ;
		change_state("Creature2Phase") ;
	else:
		change_state("EnemyPhase") ;

func inputItem():
	change_state("ItemState") ;
