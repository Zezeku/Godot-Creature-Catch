extends "res://Source/BattleScene/BattleFSM/State.gd"

onready var rng = RandomNumberGenerator.new()


func enter(fsm:StateMachine):
	_fsm = fsm
	
	print("Entering EnemyPhase")
	#load AI script here
	if Enemy.battleTeam[0] != null:
		rng.randomize() ;
		Enemy.moveUse[0] = rng.randi_range(0,Enemy.battleTeam[0].moveList.size()-1) ;
		rng.randomize() ;
		Enemy.targetUse[0] = Player.battleTeam[rng.randi_range(0,1)] ;
		
		#ADDING CURRENT PLAYER TO EXP TRACKER IF NOT SEEN BEFORE
		if Player.battleTeam[0] != null:
			if !Enemy.battleTeam[0].enemy_experience_tracker.has(Player.battleTeam[0]):
				Enemy.battleTeam[0].enemy_experience_tracker.append(Player.battleTeam[0]) ;
		if Player.battleTeam[1] != null:
			if !Enemy.battleTeam[0].enemy_experience_tracker.has(Player.battleTeam[1]):
				Enemy.battleTeam[0].enemy_experience_tracker.append(Player.battleTeam[1]) ;
	
	if Enemy.battleTeam[1] != null:
		rng.randomize() ;
		Enemy.moveUse[1] = rng.randi_range(0,Enemy.battleTeam[1].moveList.size()-1) ;
		rng.randomize() ;
		Enemy.targetUse[1] = Player.battleTeam[rng.randi_range(0,1)] ; 
		
		#ADDING CURRENT PLAYER TO EXP TRACKER IF NOT SEEN BEFORE
		if Player.battleTeam[0] != null:
			if !Enemy.battleTeam[1].enemy_experience_tracker.has(Player.battleTeam[0]):
				Enemy.battleTeam[1].enemy_experience_tracker.append(Player.battleTeam[0]) ;
		if Player.battleTeam[1] != null:
			if !Enemy.battleTeam[1].enemy_experience_tracker.has(Player.battleTeam[1]):
				Enemy.battleTeam[1].enemy_experience_tracker.append(Player.battleTeam[1]) ;
	
	
	change_state("BattlePhase") ;
