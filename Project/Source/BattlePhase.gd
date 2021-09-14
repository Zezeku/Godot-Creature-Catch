extends "res://Source/State.gd"

onready var rng = RandomNumberGenerator.new()

func enter(fsm:StateMachine):
	_fsm = fsm
	print("\nentered_battle_phase")
	
	########################## Check for running away ###########################
	if get_parent().runAttempt > 0 :
		rng.randomize() ;
		if rng.randf_range(0,1) / get_parent().runAttempt <= 0.45:
			print("You Run Away!") ;
			change_state("BattleEnd") ;
			return ; #this makes sure the code below does not run. Otherwise Godot's gameloop will still execute it despite change_state
		else:
			print("Escape Failed!!")
	
	###################### Check for Items#######################
	if Player.battleTeam[0] and (Player.itemUse[0] != null) and (Enemy.battleTeam[0] or Enemy.battleTeam[1]):
		if Enemy.battleTeam[Player.targetUse[0]]:
			Player.get_node("Inventory").useItem(Player.itemUse[0], Player.get_node("Party"), Enemy.battleTeam[Player.targetUse[0]]) ;
		else:
			Player.get_node("Inventory").useItem(Player.itemUse[0], Player, Player,Enemy.battleTeam[(Player.targetUse[0]+1)%2]) ;
	
	
	####################### Damaging Attacks ##############################
	if Player.battleTeam[0] and Player.moveUse[0] != null and (Enemy.battleTeam[0] or Enemy.battleTeam[1]):
		if Enemy.battleTeam[Player.targetUse[0]]:
			Creature.execute(Player.battleTeam[0], Player.moveUse[0], Enemy.battleTeam[Player.targetUse[0]]) ;
		else:
			Creature.execute(Player.battleTeam[0], Player.moveUse[0], Enemy.battleTeam[ (Player.targetUse[0]+1)%2 ] ) ;
	
	if Player.battleTeam[1] and Player.moveUse[1] != null and (Enemy.battleTeam[0] or Enemy.battleTeam[1]):
		if Enemy.battleTeam[Player.targetUse[1]]:
			Creature.execute(Player.battleTeam[1], Player.moveUse[1], Enemy.battleTeam[Player.targetUse[1]]) ;
		else:
			Creature.execute(Player.battleTeam[1], Player.moveUse[1], Enemy.battleTeam[ (Player.targetUse[1]+1)%2 ] ) ;
	
	if Enemy.battleTeam[0] and (Player.battleTeam[0] != null or Player.battleTeam[1]):
		if Player.battleTeam[Enemy.targetUse[0]]: 
			Creature.execute(Enemy.battleTeam[0], Enemy.moveUse[0], Player.battleTeam[Enemy.targetUse[0] ] );
		else:
			Creature.execute(Enemy.battleTeam[0], Enemy.moveUse[0], Player.battleTeam[ (Enemy.targetUse[0]+1)%2 ] );
	
	
	if Enemy.battleTeam[1] and (Player.battleTeam[0] != null or Player.battleTeam[1]):
		if Player.battleTeam[Enemy.targetUse[1]]: 
			Creature.execute(Enemy.battleTeam[1], Enemy.moveUse[1], Player.battleTeam[Enemy.targetUse[1] ] );
		else:
			Creature.execute(Enemy.battleTeam[1], Enemy.moveUse[1], Player.battleTeam[ (Enemy.targetUse[1]+1)%2 ] );
	
	
	################# Output ####################
	print("\n")
	if Player.battleTeam[0]:
		print("Player mon1: HP ", Player.battleTeam[0].stat[1], " / ", Player.battleTeam[0].stat[0]) ;
	if Player.battleTeam[1]:
		print("Player mon2: HP ", Player.battleTeam[1].stat[1], " / ", Player.battleTeam[1].stat[0]) ;
	if Enemy.battleTeam[0]:
		print("Enemy mon1: HP ", Enemy.battleTeam[0].stat[1], " / ", Enemy.battleTeam[0].stat[0]) ;
	if Enemy.battleTeam[1]:
		print("Enemy mon2: HP ", Enemy.battleTeam[1].stat[1], " / ", Enemy.battleTeam[1].stat[0]) ;
	resetRoundParams() ;
	decide_next_state() ;
	

## here we can later add states to determine mon faints, and force switch out

func decide_next_state():
	
	if (!Player.battleTeam[0] and !Player.battleTeam[1]) or (!Enemy.battleTeam[0] and !Enemy.battleTeam[1]):
		change_state("BattleEnd");
	else:
		if Player.battleTeam[0]:
			get_parent().activeChar = Player.battleTeam[0] ;
			change_state("Creature1Phase");
		else:
			get_parent().activeChar = Player.battleTeam[1] ;
			change_state("Creature2Phase");
	

func resetRoundParams():
	Player.moveUse = [null,null] ;
	Player.itemUse = [null,null] ;
	Enemy.moveUse = [null,null] ;
	
	get_parent().runAttempt = 0 ;
	
	if !Enemy.get_child(0).get_child(0):
		Enemy.battleTeam[0] = null;
	if !Enemy.get_child(0).get_child(1):
		Enemy.battleTeam[1] = null;
