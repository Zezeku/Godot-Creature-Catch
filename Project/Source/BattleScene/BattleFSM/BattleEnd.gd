extends "res://Source/BattleScene/BattleFSM/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm;
	
	#reset all player creatures stats!
	if Player.get_node("Party").get_child_count() == 0 and _fsm.history[_fsm.history.size()-1] != "StarterState":
		Player.Fainted() ;
	else:
		#this is specific to route1 trainer. needs reworked. possibly pass in trainer with encounter
		#Enemy node saves flag, so battle scene knows if its a trainer. here, we set that trainers flag to beaten
		#then route can worry about storing data
#		if Player.get_parent().isTrainer == true:
#			Player.get_parent().scene_data[2] = true ;
		
		Player.resolveCaughtQueue() ;
		Player.resetParty() ;
		
	

func inputEnter():
	SceneHandler.change_to_world_state(SceneHandler.cur_route) ;
