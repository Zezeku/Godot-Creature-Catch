extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm;
	
	print("\n\nBATTLE ENDED!!\n\n")
	
	Player.mon1.stat_changes = [1,1,1,1,1] ;
	Player.mon2.stat_changes = [1,1,1,1,1] ;
	SceneHandler.change_to_world_state() ;

