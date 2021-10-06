extends "res://Source/BattleScene/BattleFSM/State.gd"



func enter(fsm:StateMachine):
	_fsm = fsm ;
	
	
	get_parent().DisplayItems() ;
	
	
	

func decide_next_state():
	change_state("TargetPhase") ;

func inputCancel():
	get_parent().HideItems() ;
	Player.itemUse[Player.battleTeam.find(get_parent().activeChar)] = null ;
	_fsm.previous_state() ;


func inputItemSelect(item_key):
	#dont allow 2nd creature to use item creature 1 used up
	if get_parent().activeChar == Player.battleTeam[1] and item_key == Player.itemUse[0] and Inventory.getItemQty(item_key) <= 1:
		BattleLog.updateBattleLog(Player.battleTeam[0].name + " is using that item!") ;
		get_parent().DisplayItems() ;
	else:
		Player.itemUse[Player.battleTeam.find(get_parent().activeChar)] = item_key ;
		decide_next_state() ;
