extends "res://Source/State.gd"

onready var rng = RandomNumberGenerator.new()

func enter(fsm:StateMachine):
	_fsm = fsm
	
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
	#var itemOrder = [] ;
	
	if Player.battleTeam[0] and (Player.itemUse[0] != null) and (Enemy.battleTeam[0] or Enemy.battleTeam[1]):
		if Enemy.battleTeam[Player.targetUse[0]]:
			Player.get_node("Inventory").useItem(Player.itemUse[0], Player.get_node("Party"), Enemy.battleTeam[Player.targetUse[0]]) ;
			Enemy.battleTeam[Player.targetUse[0]] = null ;
		else:
			Player.get_node("Inventory").useItem(Player.itemUse[0], Player.get_node("Party"), Player,Enemy.battleTeam[(Player.targetUse[0]+1)%2]) ;
			Enemy.battleTeam[(Player.targetUse[0]+1)%2] = null ;
	
	
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
	
	
	
	for creature in attackOrder.size():
		#also try is_inside_tree if needed
		#need to make sure a creature who has died, does not go into loop
		if attackOrder[creature].get_parent() != null:
			var myself = attackOrder[creature] ;
			var my_parent = myself.get_parent().get_parent() ;
			var my_index = my_parent.battleTeam.find(myself) ;
			var isPlayer = my_parent.name == "Player" ;
				
			if isPlayer and Player.battleTeam[my_index] != null and (Enemy.battleTeam[0] !=null or Enemy.battleTeam[1]!=null) :
				if Enemy.battleTeam[my_parent.targetUse[my_index]]:
					Creature.execute(myself,my_parent.moveUse[my_index], Enemy.battleTeam[my_parent.targetUse[my_index]]) ;
				else:
					Creature.execute(myself,my_parent.moveUse[my_index], Enemy.battleTeam[(my_parent.targetUse[my_index]+1)%2]) ;
				
			elif !isPlayer and Enemy.battleTeam[my_index] != null and (Player.battleTeam[0] !=null or Player.battleTeam[1] != null):
				if Player.battleTeam[my_parent.targetUse[my_index]]:
					Creature.execute(myself, my_parent.moveUse[my_index], Player.battleTeam[my_parent.targetUse[my_index]]) ;
				else:
					Creature.execute(myself, my_parent.moveUse[my_index], Player.battleTeam[(my_parent.targetUse[my_index]+1)%2]) ;
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
