extends "res://Source/BattleScene/BattleFSM/State.gd"



func enter(fsm:StateMachine):
	_fsm = fsm
	
	
	get_parent().DisplayBattleMenu(false, false, true) ;
	

func inputRun():
	change_state("BattleEnd") ;
	

func inputItem():
	get_parent().DisplayItems() ;

func inputItemSelect(item_key):
	#item, source, target
	get_parent().useItem(item_key, Player.getCaughtQueue(), Enemy.battleTeam[0]) ;
	change_state("BattleEnd") ;
