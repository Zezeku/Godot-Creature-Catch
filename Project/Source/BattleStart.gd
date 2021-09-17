extends "res://Source/State.gd"

signal createEncounter ;
signal PlayBattleMusic ;
signal ShowBattleStart(player, enemy);
signal ShowBattleUI(player1, player2) ;
signal ShowEnemyUI(enemy1, enemy2) ;
signal ShowItemMenu();
signal showMoveMenu() ;

func enter(fsm:StateMachine):
	_fsm = fsm
	emit_signal("createEncounter") ;
	emit_signal("PlayBattleMusic") ;
	emit_signal("ShowBattleStart", Player, Enemy) ;
	
	if Player.get_node("Inventory").inventory.size() > 0:
		emit_signal("ShowItemMenu") ;
		
	get_parent().runAttempt = 0 ;
	
	Enemy.battleTeam[0] = Enemy.Party.get_child(0) ;
	Enemy.battleTeam[0].get_child(0).frame = 0 ;
	Enemy.battleTeam[0].get_child(0).scale = Vector2(1,1) ;
	Enemy.battleTeam[0].visible = true ;
	Enemy.battleTeam[0].position = Vector2(50,-75) ;
	
	if Enemy.isMon2():
		Enemy.battleTeam[1] = Enemy.Party.get_child(1) ;
		Enemy.battleTeam[1].get_child(0).frame = 0 ;
		Enemy.battleTeam[1].get_child(0).scale = Vector2(1,1) ;
		Enemy.battleTeam[1].visible = true ;
		Enemy.battleTeam[1].position = Vector2(100,-50) ;
	
	if isMon1():
		Player.battleTeam[0] = Player.Party.get_child(0) ;
		Player.battleTeam[0].get_child(0).frame = 2 ;
		Player.battleTeam[0].get_child(0).scale = Vector2(2,2) ;
		Player.battleTeam[0].visible = true ;
		Player.battleTeam[0].position = Vector2(-125,50) ;
		if isMon2():
			Player.battleTeam[1] = Player.Party.get_child(1) ;
			Player.battleTeam[1].get_child(0).frame = 2 ;
			Player.battleTeam[1].get_child(0).scale = Vector2(2,2) ;
			Player.battleTeam[1].visible = true ;
			Player.battleTeam[1].position = Vector2(-25,75) ;
	elif isMon2():
		Player.battleTeam[0] = Player.Party.get_child(1) ;
		Player.battleTeam[0].visible = true ;
		Player.battleTeam[0].position = Vector2(-125,50) ;
	else:
		emit_signal("showMoveMenu") ;
		change_state("StarterState") ;
		return ;
	
	emit_signal("ShowBattleUI",Player.battleTeam[0], Player.battleTeam[1]) ;
	emit_signal("ShowEnemyUI",Enemy.battleTeam[0], Enemy.battleTeam[1]) ;
	
	
	yield(get_node("../../../CanvasLayer/MasterUI"), "battle_start") ;
	
	
	get_parent().activeChar = Player.battleTeam[0] ;
	
	change_state("Creature1Phase") ;
	#code to initialize fight

#these should be player functions! then i can check count and hp
func isMon1(): 
	return ( Player.Party.get_child_count() > 0 )  ;
func isMon2():
	return ( Player.Party.get_child_count() > 1 ) ;
