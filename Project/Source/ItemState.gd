extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm ;
	
	print("\nenter_", get_parent().activeChar.name, "_itemState");
	print(Player.get_node("Inventory").inventory[0].itemName) ;

func decide_next_state():
	change_state("TargetPhase") ;

func inputOne():
	Player.itemUse[get_parent().activeChar.get_index()] = 0 ;
	decide_next_state() ;
	
