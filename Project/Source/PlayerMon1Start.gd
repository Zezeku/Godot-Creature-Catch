extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	print("\nentered_player_mon_1_start") ;
	print("[Moves, Run]") ;
	
	if !isMon1():
		change_state("PlayerMon2Start") ;
		return ;
		
	get_parent().activeChar = Player.battleTeam[0] ;
	get_parent().activeChar.get_child(0).frame = 3 ;
	

func isMon1():
	return Player.battleTeam[0] ;
	
func inputOne():
	change_state("MoveState") ;

func inputTwo():
	get_parent().runAttempt += 1 ;
	get_parent().activeChar.get_child(0).frame = 2 ;
	change_state("PlayerMon2Start") ;
