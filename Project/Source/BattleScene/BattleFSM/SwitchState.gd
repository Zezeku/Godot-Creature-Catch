extends "res://Source/BattleScene/BattleFSM/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	get_parent().DisplaySwitch(Player) ;


func decide_next_state():
	
	get_parent().activeChar.get_child(0).frame = 2 ;
	
	if get_parent().activeChar == Player.battleTeam[0]:
		
		if Player.battleTeam[1] != null:
			get_parent().activeChar = Player.battleTeam[1] ;
			print("Creature 1 switched, move to creature 2 phase")
			change_state("Creature2Phase") ;
		else:
			print("Creature 1 switched, no creature 2 to switch to")
			change_state("EnemyPhase") ;
	else:
		print("Creature 2 switched, move to enemy phase")
		change_state("EnemyPhase") ;

func inputCancel():
	get_parent().HideSwitch() ;
	_fsm.previous_state() ;

func inputSwitchSelect(creatureSelection):
	Player.switchUse[Player.battleTeam.find(get_parent().activeChar)] = creatureSelection ;
	decide_next_state() ;
