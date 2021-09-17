extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	
	get_parent().displayBattleMenu() ;
	emit_signal("ShowEnemyUI",Enemy.battleTeam[0], null) ;
	
	

func inputRun():
	change_state("BattleEnd")

func inputItem():
	Enemy.battleTeam[0].get_parent().remove_child(Enemy.battleTeam[0]) ;
	Player.get_node("Party").add_child(Enemy.battleTeam[0]) ;
	Player.get_node("Inventory").removeItem(0) ;
	change_state("BattleEnd")
