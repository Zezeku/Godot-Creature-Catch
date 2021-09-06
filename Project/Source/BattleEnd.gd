extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm;
	
	print("\n\nBATTLE ENDED!!\n\n")
	
	
	SceneHandler.change_to_world_state() ;

