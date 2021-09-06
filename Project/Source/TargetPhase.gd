extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm ;
	
	print("\nenter_", get_parent().activeChar.name, "_TargetPhase");
	Enemy.mon1.get_child(0).frame = 1 ;
	Enemy.mon2.get_child(0).frame = 0 ;
	Player.targetUse[get_parent().activeChar.get_index()] = 0 ;

func decide_next_state():
	
	Enemy.mon1.get_child(0).frame = 0 ;
	Enemy.mon2.get_child(0).frame = 0 ;
	
	if get_parent().activeChar == Player.mon1:
		Player.mon1.get_child(0).frame = 2 ;
		change_state("PlayerMon2Start") ;
	else :
		Player.mon2.get_child(0).frame = 2 ;
		change_state("EnemyPhase") ;

func inputOne():
	Enemy.mon1.get_child(0).frame = 1 ;
	Enemy.mon2.get_child(0).frame = 0 ;
	Player.targetUse[get_parent().activeChar.get_index()] = 0 ;

func inputTwo():
	Enemy.mon1.get_child(0).frame = 0 ;
	Enemy.mon2.get_child(0).frame = 1 ;
	Player.targetUse[get_parent().activeChar.get_index()] = 1 ;

func inputEnter():
	
	decide_next_state() ;
