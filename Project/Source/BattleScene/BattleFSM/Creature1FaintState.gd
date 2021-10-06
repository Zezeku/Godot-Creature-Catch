extends "res://Source/BattleScene/BattleFSM/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	
	get_parent().DisplaySwitch(Player) ;
	

func decide_next_state():
	get_parent().activeChar = Player.battleTeam[0] ;
	
	if Player.battleTeam[1] == null:
		change_state("Creature2FaintState") ;
	else:
		get_parent().UpdatePlayerUI_Switch(Player.battleTeam[0], 0) ;
		get_parent().UpdateTargetUI_Switch(Player.battleTeam[0], 0) ;
		change_state("Creature1Phase") ;

func inputSwitchSelect(creatureSelection):
	Player.battleTeam[0] = creatureSelection ;
	decide_next_state() ;
