extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	print("\nentered_player_mon_1_start") ;
	print("[Moves, Run]") ;
	
	get_parent().activeChar = Player.mon1 ;
	Player.mon1.get_child(0).frame = 3 ;
	

func inputOne():
	change_state("MoveState") ;

func inputTwo():
	get_parent().runAttempt += 1 ;
	change_state("PlayerMon2Start") ;
