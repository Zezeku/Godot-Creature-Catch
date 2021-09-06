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
	
	Creature.getMove(Player.mon1, Enemy.get_child(Player.targetUse[0]), Player.mon1.moveSet[Player.moveUse[0]] )
	Creature.getMove(Player.mon2, Enemy.get_child(Player.targetUse[1]), Player.mon2.moveSet[Player.moveUse[1]] )
	
	Creature.getMove(Enemy.mon1, Player.get_child(Enemy.targetUse[0]), Enemy.mon1.moveSet[Enemy.moveUse[0]] )
	Creature.getMove(Enemy.mon2, Player.get_child(Enemy.targetUse[1]), Enemy.mon2.moveSet[Enemy.moveUse[1]] )
	
	print("\n")
	print("Player mon1: HP ", Player.mon1.curHP, " / ", Player.mon1.HP) ;
	print("Player mon2: HP ", Player.mon2.curHP, " / ", Player.mon2.HP) ;
	print("Enemy mon1: HP ", Enemy.mon1.curHP, " / ", Enemy.mon1.HP) ;
	print("Enemy mon2: HP ", Enemy.mon2.curHP, " / ", Enemy.mon2.HP) ;
	
	decide_next_state() ;
	

## here we can later add states to determine mon faints, and force switch out

func decide_next_state():
	if (Player.mon1.curHP <= 0 and Player.mon2.curHP <= 0) or (Enemy.mon1.curHP <= 0 and Enemy.mon2.curHP <= 0):
		change_state("BattleEnd");
	else:
		change_state("PlayerMon1Start");
	

