extends "res://Source/State.gd"

signal PlayBattleMusic ;

func enter(fsm:StateMachine):
	_fsm = fsm
	print("entered_battle_start \n")
	emit_signal("PlayBattleMusic") ;
	get_parent().runAttempt = 0 ;
	
	change_state("PlayerMon1Start") ;
	#code to initialize fight
