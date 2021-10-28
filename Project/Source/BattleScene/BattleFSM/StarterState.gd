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
	var enemyCatch = Enemy.getPartySize() ;
	yield(Inventory.useItem(item_key, Player.getCaughtQueue(), Enemy.battleTeam[0], self), "completed") ;
	
	if Enemy.getPartySize() < enemyCatch:
		change_state("BattleEnd") ;
	else:
		Inventory.addItem(item_key, 1) ;
		change_state("StarterState") ;

func inputCancel():
	get_parent().HideItems() ;
	get_parent().DisplayBattleMenu(false, false, true) ;
	
