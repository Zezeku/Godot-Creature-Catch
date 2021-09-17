extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm ;
	
	get_parent().displayItems() ;

func decide_next_state():
	change_state("TargetPhase") ;

func inputCancel():
	get_parent().hideItemMenu() ;
	_fsm.previous_state() ;
