extends "res://Source/BattleScene/BattleFSM/State.gd"

enum {
	SELF,
	ALLY,
	ENEMY
	} ;

func enter(fsm:StateMachine):
	_fsm = fsm ;
	print("Entering target phase for creature", get_parent().activeChar.name) ;
	
	var targets = [] ;
	var target_select = null ;
	var action = null ;
	
	if _fsm.history[_fsm.history.size()-1] == "MoveState":
		action = get_parent().activeChar.moveList[Player.moveUse[Player.battleTeam.find(get_parent().activeChar)]] ;
	else:
		action = Player.itemUse[Player.battleTeam.find(get_parent().activeChar)] ;
	
	
	match action.skillTarget:
		SELF:
			targets.append(get_parent().activeChar) ;
			target_select = 1 ;
		ALLY:
			if Player.battleTeam[(Player.battleTeam.find(get_parent().activeChar)+1)%2] != null:
				targets.append(Player.battleTeam[(Player.battleTeam.find(get_parent().activeChar)+1)%2])
				target_select = 1 ;
			else:
				BattleLog.updateBattleLog("No Ally to use this ability") ;
				inputCancel();
				return ;
		ENEMY:
			for enemy in Enemy.battleTeam:
				if enemy != null:
					targets.append(enemy) ;
			target_select = 1 ;
	
	print("targets: ", targets) ;
	print("target_select: ", target_select) ;
	get_parent().ActivateTargetingUI(targets, target_select) ;



func decide_next_state():
	
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




func inputTargetSelect(targetSelect):
	Player.targetUse[Player.battleTeam.find(get_parent().activeChar)] = targetSelect ;
	decide_next_state() ;

func inputCancel():
	get_parent().HideTargetUI() ;
	Player.targetUse[Player.battleTeam.find(get_parent().activeChar)] = null ;
	_fsm.previous_state() ;
