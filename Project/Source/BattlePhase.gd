extends "res://Source/State.gd"

onready var rng = RandomNumberGenerator.new()

func enter(fsm:StateMachine):
	_fsm = fsm
	print("\nentered_battle_phase")
	
	if get_parent().runAttempt > 0 :
		rng.randomize() ;
		if rng.randf_range(0,1) / get_parent().runAttempt <= 0.45:
			print("You Run Away!") ;
			change_state("BattleEnd") ;
			return ; #this makes sure the code below does not run. Otherwise Godot's gameloop will still execute it despite change_state
		else:
			print("Escape Failed!!")
	
	
	#what if nothing to attack? ie your partner killed both others. this is just extra condition. fine for now
	if Player.battleTeam[0]:
		if Enemy.battleTeam[Player.targetUse[0]]:
			Creature.getMove(Player.battleTeam[0], Enemy.battleTeam[Player.targetUse[0]], Player.battleTeam[0].moveSet[Player.moveUse[0]] ) ;
		else:
			Creature.getMove(Player.battleTeam[0], Enemy.battleTeam[(Player.targetUse[0]+1)%2], Player.battleTeam[0].moveSet[Player.moveUse[0]] ) ;
	
	if Player.battleTeam[1]:
		if Enemy.battleTeam[Player.targetUse[1]]:
			Creature.getMove(Player.battleTeam[1], Enemy.battleTeam[Player.targetUse[1]], Player.battleTeam[1].moveSet[Player.moveUse[1]] ) ;
		else:
			Creature.getMove(Player.battleTeam[1], Enemy.battleTeam[(Player.targetUse[1]+1)%2], Player.battleTeam[1].moveSet[Player.moveUse[1]] ) ;
	
	if Enemy.battleTeam[0]:
		if Player.battleTeam[Enemy.targetUse[0]]: 
			Creature.getMove(Enemy.battleTeam[0], Player.battleTeam[Enemy.targetUse[0]], Enemy.battleTeam[0].moveSet[Enemy.moveUse[0]] ) ;
		else:
			Creature.getMove(Enemy.battleTeam[0], Player.battleTeam[(Enemy.targetUse[0]+1)%2], Enemy.battleTeam[0].moveSet[Enemy.moveUse[0]] ) ;
	
	
	if Enemy.battleTeam[1]:
		if Player.battleTeam[Enemy.targetUse[0]]: 
			Creature.getMove(Enemy.battleTeam[1], Player.battleTeam[Enemy.targetUse[1]], Enemy.battleTeam[1].moveSet[Enemy.moveUse[1]] ) ;
		else:
			Creature.getMove(Enemy.battleTeam[1], Player.battleTeam[(Enemy.targetUse[1]+1)%2], Enemy.battleTeam[1].moveSet[Enemy.moveUse[1]] ) ;
	
	print("\n")
	if Player.battleTeam[0]:
		print("Player mon1: HP ", Player.battleTeam[0].curHP, " / ", Player.battleTeam[0].HP) ;
	if Player.battleTeam[1]:
		print("Player mon2: HP ", Player.battleTeam[1].curHP, " / ", Player.battleTeam[1].HP) ;
	if Enemy.battleTeam[0]:
		print("Enemy mon1: HP ", Enemy.battleTeam[0].curHP, " / ", Enemy.battleTeam[0].HP) ;
	if Enemy.battleTeam[1]:
		print("Enemy mon2: HP ", Enemy.battleTeam[1].curHP, " / ", Enemy.battleTeam[1].HP) ;
	
	
	decide_next_state() ;
	

## here we can later add states to determine mon faints, and force switch out

func decide_next_state():
	if (!Player.battleTeam[0] and !Player.battleTeam[1]) or (!Enemy.battleTeam[0] and !Enemy.battleTeam[1]):
		change_state("BattleEnd");
	else:
		change_state("PlayerMon1Start");
	

