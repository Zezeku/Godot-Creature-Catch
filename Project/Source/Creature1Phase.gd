 extends "res://Source/State.gd"



func enter(fsm:StateMachine):
	_fsm = fsm
	print("\nentered_player_phase") ;
	
	get_parent().activeChar.get_child(0).frame = 3 ;
	get_parent().displayBattleMenu() ;
	
	


#this one is ok, specific to battle scene
func isMon1():
	return Player.battleTeam[0] ;
	
func isMon2():
	return Player.battleTeam[1] ;

func inputOne():
	change_state("MoveState") ;

func inputTwo(): #RUN option
	get_parent().runAttempt += 1 ;
	get_parent().activeChar.get_child(0).frame = 2 ;
	if isMon2():
		get_parent().activeChar == Player.battleTeam[1] ;
		change_state("Creature2Phase") ;
	else:
		change_state("EnemyPhase") ;


func inputThree():
	change_state("ItemState") ;
