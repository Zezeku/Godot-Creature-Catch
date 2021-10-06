extends "res://Source/BattleScene/BattleFSM/State.gd"



func enter(fsm:StateMachine):
	_fsm = fsm
	
	get_parent().DisplaySwitch(Player) ;
	

func decide_next_state():
	get_parent().UpdatePlayerUI_Switch(Player.battleTeam[0], 0) ;
	get_parent().UpdateTargetUI_Switch(Player.battleTeam[0], 0) ;
	
	get_parent().UpdatePlayerUI_Switch(Player.battleTeam[1], 1) ;
	get_parent().UpdateTargetUI_Switch(Player.battleTeam[1], 1) ;
	
	get_parent().activeChar = Player.battleTeam[0] ;
	
	change_state("Creature1Phase") ;

func inputCancel():
	get_parent().HideSwitch() ;
	Player.battleTeam[0] = null ;
	Player.battleTeam[1] = null ;
	_fsm.previous_state() ;

func inputSwitchSelect(creatureSelection):
	Player.battleTeam[1] = creatureSelection ;
	decide_next_state() ;
