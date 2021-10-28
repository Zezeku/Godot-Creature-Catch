extends "res://Source/BattleScene/BattleFSM/State.gd"

func enter(fsm:StateMachine):
	_fsm = fsm ;
	print("Entering resource phase for creature", get_parent().activeChar.name) ;
	
	var target = Player.targetUse[Player.battleTeam.find(get_parent().activeChar)] ;
	var move = get_parent().activeChar.moveList[Player.moveUse[Player.battleTeam.find(get_parent().activeChar)]] ;
	var is_applied = false ;
	

	#checking if player creatures using the same move this turn ..super messy. assuming no stacking
	#actually skip for now, Mark skill effect is source dependent
#	if get_parent().activeChar == Player.battleTeam[1] and Player.battleTeam[0] != null and Player.targetUse[0] == Player.targetUse[1]:
#		if Player.battleTeam[0].moveList[Player.moveUse[0]].skillName == move.skillName:
#			is_applied = true ;
	
	#does target already have this effect? if so back track. assume no stacking for now
	for effect in target.moveEffects:
		if effect.my_skill.skillName == move.skillName and effect.my_source == get_parent().activeChar:
			is_applied = true ;
			break ;
	
	if is_applied:
		BattleLog.updateBattleLog(String(target.creatureName) + " already has this effect applied")
		inputCancel() ;
	else:
		get_parent().DisplayResourceMenu(get_parent().activeChar, target, move) ;

func AetherDistribute():
	
	#when do we so the stuff? we have to remove the old aether
	
	print("Distributing Aether") ;
	get_parent().HideResourceMenu() ;
	
	get_parent().activeChar.get_child(0).frame = 2 ;
	
	if get_parent().activeChar == Player.battleTeam[0]:
		print("Target phase -- > creature 2 phase")
		if Player.battleTeam[1]:
			get_parent().activeChar = Player.battleTeam[1] ;
			change_state("Creature2Phase") ;
		else:
			change_state("EnemyPhase") ;
	else:
		print("Target phase -- > enemy phase")
		change_state("EnemyPhase") ;

func inputCancel():
	get_parent().HideResourceMenu() ;
	_fsm.previous_state() ;
	
