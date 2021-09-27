extends "res://Source/BattleScene/BattleFSM/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm ;
	
	get_parent().DisplayItems() ;

func decide_next_state():
	change_state("TargetPhase") ;

func inputCancel():
	get_parent().hideItemMenu() ;
	_fsm.previous_state() ;


func inputItemSelect(item_key):
	Player.itemUse[Player.battleTeam.find(get_parent().activeChar)] = item_key ;
	decide_next_state() ;
