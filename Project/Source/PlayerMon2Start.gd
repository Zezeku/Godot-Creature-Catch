extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	print("\nentered_player_mon_2_start") ;
	print(Player.mon2.moveSet) ;
	
	

func decide_next_state():
	change_state("EnemyPhase") ;

func inputOne():
	Player.moveUse[1] = 0 ;
	decide_next_state() ;

func inputTwo():
	Player.moveUse[1] = 1 ;
	decide_next_state() ;
	

func inputThree():
	Player.moveUse[1] = 2 ;
	decide_next_state() ;
