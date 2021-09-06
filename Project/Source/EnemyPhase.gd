extends "res://Source/State.gd"

onready var rng = RandomNumberGenerator.new()

func enter(fsm:StateMachine):
	_fsm = fsm
	print("\nentered_enemy_phase") ;
	
	rng.randomize() ;
	Enemy.moveUse[0] = rng.randi_range(0,2) ;
	
	rng.randomize() ;
	Enemy.moveUse[1] = rng.randi_range(0,2) ;
	
	change_state("BattlePhase") ;
