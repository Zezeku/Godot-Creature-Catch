extends "res://Source/BattleScene/BattleFSM/State.gd"



func enter(fsm:StateMachine):
	_fsm = fsm
	
	#BattleSetUp State
	get_parent().SetBackground() ;
	get_parent().CreateEncounter() ;
	get_parent().PlayBattleMusic() ;
	get_parent().ShowBattleStart(Player, Enemy) ;
	get_parent().runAttempt = 0 ;
	
	
	#SET BATTLE TEAMS
	#I could define a function in Player/Enemy to set battle team there

	Player.battleTeam[0] = Player.getCreature(0) ;
	if Player.getPartySize() > 1:
		Player.battleTeam[1] = Player.getCreature(1) ;
	
	Enemy.battleTeam[0] = Enemy.getCreature(0) ;
	if Enemy.getPartySize() > 1:
		Enemy.battleTeam[1] = Enemy.getCreature(1) ;
	
	
	get_parent().ShowPlayerUI(Player.battleTeam[0], Player.battleTeam[1]) ;
	get_parent().ShowEnemyUI(Enemy.battleTeam[0], Enemy.battleTeam[1]) ;
	get_parent().DisplayTargetUI(Player.battleTeam[0], Player.battleTeam[1], Enemy.battleTeam[0], Enemy.battleTeam[1]) ;



func inputBattleStart():
	
	if Player.getPartySize() == 0:
		change_state("StarterState") ;
	
	else:
		get_parent().activeChar = Player.battleTeam[0] ;
		change_state("Creature1Phase") ;
