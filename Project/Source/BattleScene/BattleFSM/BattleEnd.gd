extends "res://Source/BattleScene/BattleFSM/State.gd"



func enter(fsm:StateMachine):
	_fsm = fsm;
	
	Player.battleTeam = [null, null] ;
	#reset all player creatures stats!
	#resolve any remaining move effects, call their destroy
	if Player.get_node("Party").get_child_count() == 0 and _fsm.history[_fsm.history.size()-1] != "StarterState":
		Player.resolveEffects() ;
		Player.Fainted() ;
	else:
		#this is specific to route1 trainer. needs reworked. possibly pass in trainer with encounter
		#Enemy node saves flag, so battle scene knows if its a trainer. here, we set that trainers flag to beaten
		#then route can worry about storing data
#		if Player.get_parent().isTrainer == true:
#			Player.get_parent().scene_data[2] = true ;
		Player.resolveEffects() ;
		Player.resolveCaughtQueue() ;
		Player.resetParty() ;
		
		SceneHandler.routeHandler.changeRespawn(SceneHandler.cur_route_name, SceneHandler.player_pos, SceneHandler.player_z_index) ;
		
	
	BattleLog.updateBattleLog("  [ ENTER ]  ") ;
	

func inputEnter():
	SceneHandler.change_to_world_state(SceneHandler.cur_route_path) ;
