extends "res://Source/State.gd"


func enter(fsm:StateMachine):
	_fsm = fsm
	print("\nentered_battle_phase")
	
	print("\nPlayer Mon 1 uses ", Player.mon1.moveSet[Player.moveUse[0]], " !")
	print("Player Mon 2 uses ", Player.mon2.moveSet[Player.moveUse[1]], " !")
	
	print("\nEnemy Mon 1 uses ", Enemy.mon1.moveSet[Enemy.moveUse[0]], " !")
	print("Enemy Mon 2 uses ", Enemy.mon2.moveSet[Enemy.moveUse[1]], " !")
	
	Creature.getMove(Player.mon1, Enemy.mon1, Player.mon1.moveSet[Player.moveUse[0]] )
	Creature.getMove(Player.mon2, Enemy.mon2, Player.mon2.moveSet[Player.moveUse[1]] )
	
	Creature.getMove(Enemy.mon1, Player.mon1, Enemy.mon1.moveSet[Enemy.moveUse[0]] )
	Creature.getMove(Enemy.mon2, Player.mon2, Enemy.mon2.moveSet[Enemy.moveUse[1]] )
	
	print("\n")
	print("Player mon1: HP ", Player.mon1.curHP, " / ", Player.mon1.HP) ;
	print("Player mon2: HP ", Player.mon2.curHP, " / ", Player.mon2.HP) ;
	print("Enemy mon1: HP ", Enemy.mon1.curHP, " / ", Enemy.mon1.HP) ;
	print("Enemy mon2: HP ", Enemy.mon1.curHP, " / ", Enemy.mon2.HP) ;
	
	decide_next_state() ;
	

func decide_next_state():
	if (Player.mon1.curHP <= 0 and Player.mon2.curHP) or (Enemy.mon1.curHP <= 0 and Enemy.mon2.curHP):
		change_state("BattleEnd");
	else:
		change_state("PlayerMon1Start");
	


	#need functions for each attack. each attack needs source + target(s)
	#need damage taken that needs source + target
	#for now keep it a seperate CREATURE script
	#this will be turned into scriptable objects later
	
