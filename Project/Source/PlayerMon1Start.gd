extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	print("\nentered_player_mon_1_start") ;
	print(Player.mon1.moveSet) ;
	
	

func isMon2():
	return Player.get_child_count() > 1 ;

func decide_next_state():
	if isMon2():
		change_state("PlayerMon2Start") ;
	#else: go to enemy state. we must assume enemy has at least 1 mon or else
	# the previous iteration of battle state wouldve ended encounter

func inputOne():
	Player.moveUse[0] = 0 ;
	decide_next_state()

func inputTwo():
	Player.moveUse[0] = 1 ;
	decide_next_state()
	
func inputThree():
	Player.moveUse[0] = 2 ;
	decide_next_state()
