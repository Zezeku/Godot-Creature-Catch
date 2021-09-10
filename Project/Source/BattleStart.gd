extends "res://Source/State.gd"

signal PlayBattleMusic ;

func enter(fsm:StateMachine):
	_fsm = fsm
	print("entered_battle_start \n")
	emit_signal("PlayBattleMusic") ;
	get_parent().runAttempt = 0 ;
	
	Enemy.battleTeam[0].visible = true ;
	Enemy.battleTeam[0].position = Vector2(50,-75) ;
	
	Enemy.battleTeam[1].visible = true ;
	Enemy.battleTeam[1].position = Vector2(100,-50) ;
	
	Player.battleTeam[0].visible = true ;
	Player.battleTeam[0].position = Vector2(-125,50) ;
	
	Player.battleTeam[1].visible = true ;
	Player.battleTeam[1].position = Vector2(-25,75) ;
	
	change_state("PlayerMon1Start") ;
	#code to initialize fight
