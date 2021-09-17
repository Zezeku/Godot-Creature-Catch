extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm ;
	

	if !Enemy.battleTeam[0] and Enemy.battleTeam[1]:
		Enemy.battleTeam[1].get_child(0).frame = 1 ;
		Player.targetUse[get_parent().activeChar.get_index()] = 1 ;
	
	elif !Enemy.battleTeam[1] and Enemy.battleTeam[0]:
		Enemy.battleTeam[0].get_child(0).frame = 1 ;
		Player.targetUse[get_parent().activeChar.get_index()] = 0 ;
	
	else:
		Enemy.battleTeam[1].get_child(0).frame = 0 ;
		Enemy.battleTeam[0].get_child(0).frame = 1 ;
		Player.targetUse[get_parent().activeChar.get_index()] = 0 ;


func decide_next_state():
	
	if Enemy.battleTeam[0]:
		Enemy.battleTeam[0].get_child(0).frame = 0 ;
	if Enemy.battleTeam[1]:
		Enemy.battleTeam[1].get_child(0).frame = 0 ;
		
	
	get_parent().activeChar.get_child(0).frame = 2 ;
	
	if get_parent().activeChar == Player.battleTeam[0]:
		
		if Player.battleTeam[1]:
			get_parent().activeChar = Player.battleTeam[1] ;
			change_state("Creature2Phase") ;
		else:
			change_state("EnemyPhase") ;
	else:
		change_state("EnemyPhase") ;



func inputOne():
	if Enemy.battleTeam[0] and Enemy.battleTeam[1]:
		Enemy.battleTeam[0].get_child(0).frame = 1 ;
		Enemy.battleTeam[1].get_child(0).frame = 0 ;
		Player.targetUse[get_parent().activeChar.get_index()] = 0 ;


func inputTwo():
	if Enemy.battleTeam[0] and Enemy.battleTeam[1]:
		Enemy.battleTeam[0].get_child(0).frame = 0 ;
		Enemy.battleTeam[1].get_child(0).frame = 1 ;
		Player.targetUse[get_parent().activeChar.get_index()] = 1 ;


func inputEnter():
	decide_next_state() ;

func inputCancel():
	Player.targetUse[get_parent().activeChar.get_index()] = null ;
	if Enemy.battleTeam[0]:
		Enemy.battleTeam[0].get_child(0).frame = 0 ;
	if Enemy.battleTeam[1]:
		Enemy.battleTeam[1].get_child(0).frame = 0 ;
		
	_fsm.previous_state() ;
