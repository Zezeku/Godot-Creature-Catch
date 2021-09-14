extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	
	print("\nentered_player_mon_2_start") ;
	
	if !isMon2():
		change_state("EnemyPhase") ;
		return ;
	
	get_parent().activeChar.get_child(0).frame = 3 ;
	get_parent().displayBattleMenu() ;
	

func isMon2():
	return Player.battleTeam[1] ;

func inputOne():
	change_state("MoveState") ;

func inputTwo():
	get_parent().runAttempt += 1 ;
	get_parent().activeChar.get_child(0).frame = 2 ;
	change_state("EnemyPhase") ;

func inputThree():
	change_state("ItemState") ;
