extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm;
	
	#reset all player creatures stats!
	if Player.get_node("Party").get_child_count() == 0 and _fsm.history[_fsm.history.size()-1] != "StarterState":
		Player.Fainted() ;
	else:
		if Player.get_parent().isTrainer == true:
			Player.get_parent().scene_data[2] = true ;
		Player.resetParty() ;
	
	var t = Timer.new() ;
	add_child(t) ;
	t.one_shot = true ;
	t.autostart = false ;
	t.wait_time = 1.0 ;
	t.start() ;
	yield(t, "timeout") ;
	
	
	SceneHandler.change_to_world_state() ;

