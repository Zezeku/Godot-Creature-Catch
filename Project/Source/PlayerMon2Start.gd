extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	
	print("\nentered_player_mon_2_start") ;
	if !isMon2():
		change_state("EnemyPhase") ;
	
	print("[Moves, Run]") ;
	
	
	get_parent().activeChar = Player.mon2 ;
	Player.mon2.get_child(0).frame = 3 ;
	

func isMon2():
	return Player.get_child_count() > 1 ;

func inputOne():
	change_state("MoveState") ;

func inputTwo():
	get_parent().runAttempt += 1 ;
	change_state("EnemyPhase") ;
