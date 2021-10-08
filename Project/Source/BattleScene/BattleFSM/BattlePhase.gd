extends "res://Source/BattleScene/BattleFSM/State.gd"

onready var rng = RandomNumberGenerator.new()

func enter(fsm:StateMachine):
	_fsm = fsm
	
	
	print("Entering BattlePhase")
	#should we place in seperate states? allows for battle end as needed
	#idea - RunCheckState -> SwitchCheckState -> ItemCheckState -> BattleCheckState
	
	
	########################## Check for running away ###########################
	if get_parent().runAttempt > 0 :
		rng.randomize() ;
		if rng.randf_range(0,1) / get_parent().runAttempt <= 0.45:
			BattleLog.updateBattleLog("You Run Away!")
			change_state("BattleEnd") ;
			return ; #this makes sure the code below does not run. Otherwise Godot's gameloop will still execute it despite change_state
		else:
			BattleLog.updateBattleLog("Escaped Fail!")
	
	###################### Check for Switch #######################
	if Player.battleTeam[0] and Player.switchUse[0] != null:
		var swapIndex = Player.switchUse[0].get_index() ;
		Player.get_node("Party").move_child(Player.switchUse[0], Player.battleTeam[0].get_index() );
		Player.get_node("Party").move_child(Player.battleTeam[0], swapIndex );
		
		#make sure enemy updates its target to swap in
		if Enemy.battleTeam[0] != null and Enemy.targetUse[0] == Player.battleTeam[0]:
			Enemy.targetUse[0] = Player.switchUse[0]
		if Enemy.battleTeam[1] != null and Enemy.targetUse[1] == Player.battleTeam[0]:
			Enemy.targetUse[1] = Player.switchUse[0]
		
		Player.battleTeam[0] = Player.switchUse[0] ;
		get_parent().UpdatePlayerUI_Switch(Player.battleTeam[0], 0) ;
		get_parent().UpdateTargetUI_Switch(Player.battleTeam[0], 0) ;
		
		#ADDING TO ENEMY EXP TRACKER TO SHARE SWITCH INS
		if Enemy.battleTeam[0] != null:
			if !Enemy.battleTeam[0].enemy_experience_tracker.has(Player.battleTeam[0]):
				Enemy.battleTeam[0].enemy_experience_tracker.append(Player.battleTeam[0])
		if Enemy.battleTeam[1] != null:
			if !Enemy.battleTeam[1].enemy_experience_tracker.has(Player.battleTeam[0]):
				Enemy.battleTeam[1].enemy_experience_tracker.append(Player.battleTeam[0])
		
	
	if Player.battleTeam[1] and Player.switchUse[1] != null:
		var swapIndex = Player.switchUse[1].get_index() ;
		Player.get_node("Party").move_child(Player.switchUse[1], Player.battleTeam[1].get_index() );
		Player.get_node("Party").move_child(Player.battleTeam[1], swapIndex );
		
		#make sure enemy updates its target to swap in
		if Enemy.battleTeam[0] != null and Enemy.targetUse[0] == Player.battleTeam[1]:
			Enemy.targetUse[0] = Player.switchUse[1]
		if Enemy.battleTeam[1] != null and Enemy.targetUse[1] == Player.battleTeam[1]:
			Enemy.targetUse[1] = Player.switchUse[1]
			
		Player.battleTeam[1] = Player.switchUse[1] ;
		get_parent().UpdatePlayerUI_Switch(Player.battleTeam[1], 1) ;
		get_parent().UpdateTargetUI_Switch(Player.battleTeam[1], 1) ;
		
		#ADDING TO ENEMY EXP TRACKER TO SHARE SWITCH INS
		if Enemy.battleTeam[0] != null:
			if !Enemy.battleTeam[0].enemy_experience_tracker.has(Player.battleTeam[1]):
				Enemy.battleTeam[0].enemy_experience_tracker.append(Player.battleTeam[1])
		if Enemy.battleTeam[1] != null:
			if !Enemy.battleTeam[1].enemy_experience_tracker.has(Player.battleTeam[1]):
				Enemy.battleTeam[1].enemy_experience_tracker.append(Player.battleTeam[1])
	
	
	
	###################### Check for Items#######################
	
	if Player.battleTeam[0] != null and (Player.itemUse[0] != null) and Enemy.getPartySize() > 0:
		if Player.targetUse[0] != null:
			yield(Player.get_node("Inventory").useItem(Player.itemUse[0], Player.get_node("CaughtQueue"), Player.targetUse[0], self), "completed") ;
		else:
			var new_target ;
			for creature in Enemy.battleTeam:
				if creature != null:
					new_target = creature ;
					break ;
			Player.get_node("Inventory").useItem(Player.itemUse[0], Player.get_node("CaughtQueue"), new_target, self) ;
	
	if Player.battleTeam[1] != null and (Player.itemUse[1] != null) and Enemy.getPartySize() > 0:
		if Player.targetUse[1] != null:
			Player.get_node("Inventory").useItem(Player.itemUse[1], Player.get_node("CaughtQueue"), Player.targetUse[1], self) ;
		else:
			var new_target ;
			for creature in Enemy.battleTeam:
				if creature != null:
					new_target = creature ;
					break ;
			Player.get_node("Inventory").useItem(Player.itemUse[1], Player.get_node("CaughtQueue"), new_target, self) ;
	
	
	####################### Damaging Attacks ##############################
	
	var attackOrder = [] ;
	
	if Player.battleTeam[0] and Player.moveUse[0] != null:
		attackOrder.append(Player.battleTeam[0]) ;
	
	if Player.battleTeam[1] and Player.moveUse[1] != null:
		attackOrder.append(Player.battleTeam[1]) ;
	
	if Enemy.battleTeam[0] and Enemy.moveUse[0] != null:
		attackOrder.append(Enemy.battleTeam[0]) ;
	
	if Enemy.battleTeam[1] and Enemy.moveUse[1] != null:
		attackOrder.append(Enemy.battleTeam[1]) ;
	
	if attackOrder.size() > 0:
		attackOrder.sort_custom(attackOrder[0], "sortSpd") ;
	#the sortSpd exists in CreatureX script. since all creatures come from CreatureX
	
	
	for creature in attackOrder.size():
		#also try is_inside_tree if needed
		#need to make sure a creature who has died, does not go into loop
		if attackOrder[creature].is_inside_tree(): #checks node is still in tree
			if attackOrder[creature].get_parent().name != "Fainted":#extra condition for player since they dont get deleted from scene on faint
				var myself = attackOrder[creature] ;
				var my_parent = myself.get_parent().get_parent() ;
				var my_index = my_parent.battleTeam.find(myself) ;
				var isPlayer = my_parent.name == "Player" ;
				var mySkill = myself.moveList[my_parent.moveUse[my_index]]
					
				if isPlayer and Player.battleTeam[my_index] != null and (Enemy.battleTeam[0] !=null or Enemy.battleTeam[1]!=null) :
					if my_parent.targetUse[my_index] != null:
						mySkill.execute(myself, my_parent.targetUse[my_index], self) ;
					else:
						var new_target ;
						for new_creature in Enemy.battleTeam:
							if new_creature != null:
								new_target = new_creature ;
								break ;
						mySkill.execute(myself, new_target, self) ;
					
				elif !isPlayer and Enemy.battleTeam[my_index] != null and (Player.battleTeam[0] !=null or Player.battleTeam[1] != null):
					if my_parent.targetUse[my_index] != null:
						mySkill.execute(myself, my_parent.targetUse[my_index], self) ;
					else:
						var new_target ;
						for new_creature in Player.battleTeam:
							if new_creature != null:
								new_target = new_creature ;
								break ;
						mySkill.execute(myself, new_target, self) ;
						
				elif (Player.battleTeam[0] !=null or Player.battleTeam[1] != null) and (Enemy.battleTeam[0] !=null or Enemy.battleTeam[1]!=null):
					pass ; #if current creature died, but still other creatures on either side, keep looping
				
				else:
					break; #if either side has lost both creatures, end the attack loop
					#note this is different from ending encounter. it just ends this attack loop
					#encounter check is further down
		
	
	resetRoundParams() ;
	decide_next_state() ;
	

## here we can later add states to determine mon faints, and force switch out

func decide_next_state():
	
	### BATTLE ENDS WHEN EITHER SIDE HAS NO MORE CREATURE IN PARTY ##
	if (Player.getPartySize() == 0) or (Enemy.getPartySize() == 0):
		change_state("BattleEnd");
	
	### LOGIC FOR PLAYER WITH EXACTLY ONE CREATURE LEFT - ONLY ONE SLOT TO BE FILLED ###
	elif Player.getPartySize() == 1:
		if Player.battleTeam[0] != null:
			get_parent().activeChar = Player.battleTeam[0] ;
			change_state("Creature1Phase");
		elif Player.battleTeam[1] != null:
			get_parent().activeChar = Player.battleTeam[1] ;
			change_state("Creature2Phase");
		else:
			Player.battleTeam[0] = Player.get_node("Party").get_child(0) ;
			get_parent().activeChar = Player.battleTeam[0] ;
			get_parent().UpdatePlayerUI_Switch(Player.battleTeam[0], 0) ;
			get_parent().UpdateTargetUI_Switch(Player.battleTeam[0], 0) ;
			change_state("Creature1Phase");
	
	### LOGIC FOR PLAYER WITH 2+ CREATURES LEFT - BOTH SLOTS TO BE FILLED ###
	else:#this might be worthy of another state to allow switching, default for now
		if Player.battleTeam[0] == null:
			change_state("Creature1FaintState") ;
			
		elif Player.battleTeam[1] == null:
			change_state("Creature2FaintState");
			
		else: #BOTH CREATURES STILL ALIVE, CONTINUE
			get_parent().activeChar = Player.battleTeam[0] ;
			change_state("Creature1Phase");

func resetRoundParams():
	Player.moveUse = [null,null] ;
	Player.itemUse = [null,null] ;
	Player.switchUse = [null, null] ;
	Enemy.moveUse = [null,null] ;
	#Enemy.itemUse = [null,null] ;
	
	get_parent().runAttempt = 0 ;
